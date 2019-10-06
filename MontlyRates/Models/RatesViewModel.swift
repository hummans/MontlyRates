//
//  RatesViewModel.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

public typealias  TupledRates = [(date:String,rate:Double)]

protocol RatesViewModelProtocol: class {
	func fetchRatesBegan()
	func fetchRatesFailed(error: String , cachedData: [RatesModel])
	func fetchRatesSuccess(rates: [RatesModel])
}

class RatesViewModel : NSObject {
	var service : WebServices!
	var delegate : RatesViewModelProtocol!
	
	private var fetchConvertedRatesOps : FetchRatesOperation!
	
	override init() {
	   super.init()
		  service = WebServices()
    	fetchConvertedRatesOps = FetchRatesOperation(_ratesVmodel: self)
  }

	//- Fetch All rates with currencies from endPoint
	//- on fetch Transform results to Rates model
	func fetchRates(){
		guard let delegate = self.delegate else { return  }
		delegate.fetchRatesBegan()
		
		service.fetchExchangeRates(completion: {  result in
			switch result {
				case .success(let data):
					if data.rates.count == 0 {
						delegate.fetchRatesFailed(error: "Empty data",
																			cachedData: self.cachedRatesModel!)
					}else{
						self.cacheRatesModel(rates: data.toRatesModel)
						delegate.fetchRatesSuccess(rates: data.toRatesModel)
						
					}
				
			case .failure(let error):
				delegate.fetchRatesFailed(error: error.StringDescription,
																	cachedData: self.cachedRatesModel!)
			}
		})
	}
	
	
	//- Fetch rates for the first 5months in 2019 specific months
	//- Apply logic to get percentage differnce
	//- Transform to RatesConvertedModel
	
	func getPercentageDifference(forCurrency: String,
																 _ convertedRates: @escaping([RatesConvertedModel],[RequestError])-> Void){
		fetchConvertedRatesOps.getRatesOperations(forCurrency: forCurrency) { rates, errors in
			          convertedRates(rates,errors)
		}
		
	}
	
	
	
	// - Cache Rates returned locally , for use in offline mode,
	// - i manually disabled the Caching on the endpoint
	// - by setting  .reloadIgnoringLocalAndRemoteCacheData

	func cacheRatesModel(rates: [RatesModel]) {
		do {
			try StorageService.saveData(data: rates, key: RatesModelKey)
		}catch{
			  //HANDLE ERROR
		}
	}
	
	//- Fetch Catch from Userdefaults
	var cachedRatesModel : [RatesModel]?{
		var rates : [RatesModel] = []
		do{
			rates = try StorageService.getData(key: RatesModelKey)
		}catch{
			rates = []
		 }
		 return rates
	}
	
}


extension RatesViewModel{
	
	//- Get first five month in 2019 using NSDateComponents
	var  firstFiveMonthIn2019 : [String]{
		var dates : [String] = []
		for month in 1...5 {
			if let date = DateComponents(calendar: Calendar.current,
																	 year: 2019,
																	 month: month,
																	 day: 1).date {
				let formatter = DateFormatter()
				formatter.dateFormat = "yyyy-MM-dd"
				let d = 	formatter.string(from: date)
				dates.append(d)
			}
		}
		return dates
	}
	
	//- Get the rate value for a specific currency code ,
	//- in a Dictionary of rates.
	func rateValueForKey(key: String ,
											 rates: [String: Double]) -> Double {
	   	var value = 0.0
		  value = rates[key] ?? 0.0
		  return value
	   }
	 }

extension TupledRates {
	
	//- Convert Rates response to a list of RatesConvertedModel
	//- apply logic to get difference from each rate value in the List of Tuples
	
	var  ratesConverted : [RatesConvertedModel]{
		var sortedRates =  self.sorted{ $0.0 < $1.0 }
		var values : [RatesConvertedModel]  = []
		values = sortedRates.indices.map { i in
			/**
			* - (sortedRates[i].1) Get an index of sortedRates  as `A`.
			* - (sortedRates[Swift.max(0, i-1)].1) derive the leading Index of `A`,
			as  `B`.
			* - Use Swift.max(0,i-1) to return the greater between the derived index,
			if its a negative index return 0.
			* - subtract B from A and Divide by B then multiple by 100.
			*/
			let difference = self.percentileDiffLogic(firstOne: (sortedRates[i].1 - sortedRates[Swift.max(0,i-1)].1),
																								
																					       secondOne: sortedRates[Swift.max(0, i-1)].1)
			
			return	RatesConvertedModel(date: sortedRates[i].0,
																	rate: sortedRates[i].1,
																	converted: difference)
		}
		sortedRates = []
		return values.reversed()
	}
	
	//- Simple maths for percentile differentiation logic
	func percentileDiffLogic(firstOne : Double,
													 secondOne: Double) -> Double{
		   var value = 0.0
		   value = ( firstOne / secondOne) * 100
			 return value
	}

}



//firt tymes 

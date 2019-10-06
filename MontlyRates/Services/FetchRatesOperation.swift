//
//  FetchRatesOperation.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import UIKit



class FetchRatesOperation : NSObject {
	
	var ratesVmodel : RatesViewModel!
	var ratesOpQ : OperationQueue!
	var group : DispatchGroup!
	var queue : DispatchQueue!

	init(_ratesVmodel : RatesViewModel) {
		 self.ratesVmodel = _ratesVmodel
		 self.ratesOpQ = OperationQueue()
		 self.group = DispatchGroup()
		 self.queue = DispatchQueue(label: "com.fetch.rates.queue")
	}
	
	
	//- Using Block Operations  and DispatchGroup, fetch mutliple exchangeRates
	//- transform to list of RatesConvertedModel
	func getRatesOperations(forCurrency: String,
																 convertedRates: @escaping([RatesConvertedModel],[RequestError])-> Void){
		var rates : TupledRates = []
		var errors : [RequestError] = []
		ratesVmodel.firstFiveMonthIn2019.forEach{ date in
			group.enter()
			let operation = BlockOperation {
				  self.ratesVmodel.service.fetchExchangeRates(urlString:EndPoint.Base,
																			              	parameters: date,
																			              	completion: { [weak self] result in
					defer { self?.group.leave() }
																					
					switch result {
					case .success(let data):
					let _rates = data.rates
					if _rates.count != 0{
					
						rates.append((date,	self?.ratesVmodel.rateValueForKey(key: forCurrency,
																																				rates: _rates) ?? 0.00))
					}
					case .failure(let error):
						errors.append(error)
						break
					}
				})
			}
			ratesOpQ.addOperation(operation)
		}
		group.notify(queue: .main) {
			convertedRates(rates.ratesConverted, errors)
		}
	}
	
	//- Using DispatchWorkItem Operations,  DispatchQueu eand DispatchGroup, fetch mutliple exchangeRates
	//- transform to list of RatesConvertedModel
/**	func getRatesMonthlyDifferenceDispatchWorkItem(forCurrency: String,convertedRates: @escaping([RatesConvertedModel],[RequestError])-> Void){
		var workItems : [DispatchWorkItem] = []
		var rates : TupledRates = []
		var errors : [RequestError] = []
			ratesVmodel.firstFiveMonthIn2019.forEach{ date in
			group.enter()
			let workItem = DispatchWorkItem {
				self.ratesVmodel.service.fetchExchangeRates(urlString:EndPoint.Base,
																				parameters: date,
																				completion: { [weak self] result in
					defer { self?.group.leave() }
					switch result {
					case .success(let data):
						let _rates = data.rates
						if _rates.count != 0{
							rates.append((date,	self?.ratesVmodel.rateValueForKey(key: forCurrency,
																																					rates: _rates) ?? 0.00))
						}
					case .failure(let error):
						 	errors.append(error)
						break
					}
					
				})
			}
			workItems.append(workItem)
		}
		workItems.forEach{ queue.async(group: group, execute: $0)}
		group.notify(queue: .main) {
			convertedRates(rates.ratesConverted, errors)
		}
	} **/

}


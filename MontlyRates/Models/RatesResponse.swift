//
//  Rates.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

struct RatesResponse : Codable {
	let base, date: String?
	let rates :  [String: Double]
}

extension RatesResponse {
	
 var toRatesModel : [RatesModel]{
		 var model : [RatesModel] = []
		 model = self.rates.compactMap{ RatesModel(code: $0.key, rateValue: $0.value) }
		 return model
	}
}

//
//  Currency.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation


let RatesModelKey = "RatesModelKey"

class RatesModel : NSObject,Codable {
	var code : String!
	var countryName : String!
	var flagIconName:String!
	var rate: Double!
	
	init(code : String,rateValue: Double) {
		self.code = code
		self.countryName = Locale.current.localizedString(forCurrencyCode:  code)
		self.flagIconName = code.lowercased()
		self.rate = rateValue
	}
	
	
	
}

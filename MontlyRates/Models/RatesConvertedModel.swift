//
//  RatesConvertedModel.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
class RatesConvertedModel : NSObject {
	var date : String!
	var rate: Double!
	var convertedValue : Double!
	var formattedConvertedValue : String!
	
	init(date:String,rate:Double,converted: Double) {
		self.date = date.humanReadableMonth
		self.rate = rate
		self.convertedValue = converted
		self.formattedConvertedValue = converted.percentageStyleFormat
	}
	
}

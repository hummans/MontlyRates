//
//  EndPoint.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation

struct DefaultTimeout {
	static let  timeoutInterval: Double = 10.0
}


struct EndPoint {
	static let Base = "https://api.exchangeratesapi.io/"
	static let latest = Base + "latest"
}

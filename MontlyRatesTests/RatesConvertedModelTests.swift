//
//  RatesConvertedModelTests.swift
//  MontlyRatesTests
//
//  Created by Engineer 144 on 27/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import XCTest

@testable import MontlyRates
class RatesConvertedModelTests: XCTestCase {

	var mockedModel : RatesConvertedModel!
    override func setUp() {
			mockedModel = RatesConvertedModel(date: "", rate: 0.00, converted: 0.00)
    }

    override func tearDown() {
        mockedModel = nil
			  super.tearDown()
    }

	

}

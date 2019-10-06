//
//  RatesModelTests.swift
//  MontlyRatesTests
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import XCTest
@testable import MontlyRates
class RatesModelTests: XCTestCase {

	var mockedModel : RatesModel!
    override func setUp() {
			mockedModel = RatesModel(code: "AUD", rateValue: 1.00)
    }

    override func tearDown() {
       mockedModel = nil
			 super.tearDown()
    }
	
	 
	func testValueInModel(){
		XCTAssertNotEqual(mockedModel.code.count, 0, "Code cannot be empty")
		
		XCTAssertNotEqual(mockedModel.rate, 0.00,"Rates should be Greater than 0")
		
		XCTAssertNotNil(mockedModel.flagIconName.flagImage,"Currency Image must exist in Assets")
		
		XCTAssert(mockedModel.code.count == 3, "Currency Code must be equal to 3")
		
		XCTAssertNotNil(mockedModel.countryName, "Currency name Must not be Nil ")
		
	}
	

}

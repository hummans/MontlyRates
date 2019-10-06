//
//  RatesViewModelTests.swift
//  MontlyRatesTests
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import XCTest
@testable import MontlyRates
class RatesViewModelTests: XCTestCase {

	var mockedVModel : RatesViewModel!
    override func setUp() {
        mockedVModel = RatesViewModel()
    }

    override func tearDown() {
        mockedVModel = nil
			  super.tearDown()
    }

	func testsMonthsNeeded(){
		   XCTAssert(mockedVModel.firstFiveMonthIn2019.count == 5, "First five months count should be Five")
	}
	
	
	func testsFetchRate(){
		let expect = expectation(description: "Test getPercentageDifference")
		mockedVModel.getPercentageDifference(forCurrency: "AUD") { (rates, errors) in
			XCTAssert(errors.count == 0 , "Must not return any Errors")
			expect.fulfill()
		}
		
		waitForExpectations(timeout: 0.4) { (error) in
			XCTAssert(true, "Timed out" )

		}
	}
	
	

}

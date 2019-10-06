//
//  WebServiceTest.swift
//  MontlyRatesTests
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import XCTest

@testable import MontlyRates

class WebServiceTest: XCTestCase {
	
	var webservice : WebServices!
    override func setUp() {
			webservice = WebServices()
    }
    override func tearDown() {
			webservice = nil
			super.tearDown()
    }
	
	func testAPIRequestParamsShouldNotBeNil(){
			XCTAssertThrowsError(try APIURLRequest(urlString: nil, method: nil, params: nil, headers: nil))
	}
	func testAPIRequestParamsShouldNotProcessEmptyUrlString(){
		   XCTAssertThrowsError(try APIURLRequest(urlString: "", method: .get, params: nil, headers: [:]))
	}
	func testFetchExchangeRates(){
		  let expect = expectation(description: "Test mode")
		  let badURLString = ""
		   webservice.fetchExchangeRates(urlString :badURLString, parameters: nil) { (results) in
				switch results {
				case .success(_):
					XCTAssert(false, "FetchRates should not execute with bad urls provided" )
				case .failure(_):
					XCTAssert(true, "FetchRates should fail with bad urls" )
				 }
					expect.fulfill()
				  }
			     waitForExpectations(timeout: 5.0, handler: { _ in
							XCTAssert(true, "Timed out" )
				   })
	    }
	
	func testRequestExecutor(){
		let request = try? APIURLRequest(urlString: nil, method: nil, params: nil, headers: nil)
		let executor = try? RequestExecuter(request)
		XCTAssertNil(executor?.request)
	}

}

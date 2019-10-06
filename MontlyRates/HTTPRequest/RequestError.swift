//
//  RequestError.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation


enum RequestError: Error {
	case unknown(Error)
	case badUrl
	case noResponse
	case noData
	case failedToDecode(Error)
	case failDecode(Data,Error)
	case noInternet
	case badBody
	case authRequired
	case hostUnknown
	case badResponse
	case badRequest
	case fakeError

}

extension RequestError {
	
	var StringDescription : String {
		var errorString = ""
		switch self {
		case .unknown(let self):
			errorString = "\(self.localizedDescription)"
		case .badUrl:
			errorString = "Bad Url from URLrequest"
		case .noResponse:
			errorString = "No response from server"
		case .noData:
			errorString = "No data returned from server"
		case .failedToDecode(let self):
			errorString = "\(self)"
		case .noInternet:
			errorString = "No internet connection established"
		case .badBody:
			errorString = "Bad request body"
		case .authRequired:
			errorString = "Authorization required"
		case .hostUnknown:
			errorString = "Unknown Host"
		case .badResponse:
			errorString = "Bad response "
		case .badRequest:
			errorString = "Bad Request Set up"
		case .fakeError:
			errorString = "fakeError"
		case .failDecode(let data):
			errorString =  data.0.debugDescription + data.1.localizedDescription
		}
		
		return errorString
	}
	
}

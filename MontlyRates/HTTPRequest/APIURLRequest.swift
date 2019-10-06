//
//  APIURLRequest.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
class APIURLRequest {
	
private	var defaultTimeOut: TimeInterval!
var request : URLRequest!
private	var httpMethod: HTTPMethod!
private	var parameter:QueryStringValue!
private	var urlString: String!
	
	private lazy var headers: [String:String] = {
		var defaultHeaders = [String:String]()
		defaultHeaders["Content-Type"] = "application/json"
		return defaultHeaders
	}()
	
	
	init(urlString: String?,
			 method: HTTPMethod?,
			 params: QueryStringValue?,
			 headers: RequestHeaders?,
			 timeoutInterval: TimeInterval = 10) throws {
		
		
		guard let _method = method else {  throw RequestError.badUrl }
		guard let _urlString = urlString else {  throw RequestError.badUrl }
		if _urlString.count <= 0 {  throw RequestError.badUrl }
		guard let _header = headers else {  throw RequestError.badRequest }
		guard let param = params else { throw RequestError.badBody  }
		
		self.httpMethod = _method
		self.headers.update(other: _header)
		self.parameter = param
	
		switch _method {
		case .get:
			
			let finalUrlString : QueryStringValue =  _urlString.appending(param)
			guard let finalUrl = URL(string: finalUrlString) else { throw RequestError.badUrl }
			self.request = URLRequest(url:finalUrl , timeoutInterval: timeoutInterval)
			self.request.allHTTPHeaderFields =  self.headers
		
		case .post: break
		
			
		}
		
	}
	
	
	
}

//
//  RequestExecuter.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
final class RequestExecuter {
	let urlSession = URLSession.shared
	var request : APIURLRequest!
	
	init(_ request : APIURLRequest?) throws {
		guard let _request = request else { throw RequestError.badRequest }
		self.request = _request
	}
	
	func fireRequest<T>(completionQueue: DispatchQueue = .main,
											completionHandler: @escaping (Result<T,RequestError>) -> Void) where T : Decodable{
		request.request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
		urlSession.dataTask(with: request.request) { (data, response, error) in
		
			guard error == nil else {return completionHandler(.failure(RequestError.unknown(error!)))}
			guard let data = data else {return completionHandler(.failure(RequestError.noData))}
			guard let httpResponse = response as? HTTPURLResponse else { return completionHandler(.failure(RequestError.noResponse)) }
			
			switch httpResponse.statusCode {
			case 200...299:
				do {
					let value = try JSONDecoder().decode(T.self, from: data)
					return completionHandler(.success(value))
				}
				catch let error {
					return completionHandler(.failure(RequestError.failDecode(data,error)))
				}
			case 400 :
				do {
					let value = try JSONDecoder().decode(T.self, from: data)
					return completionHandler(.success(value))
				}
				catch let error {
					return completionHandler(.failure(RequestError.failedToDecode(error)))
				}
			case 403:
				return completionHandler(.failure(RequestError.authRequired))
			case 404:
				return completionHandler(.failure(RequestError.hostUnknown))
			case 500:
				return completionHandler(.failure(RequestError.badResponse))
			default: break
			}
			}.resume()
	}
	
	
}

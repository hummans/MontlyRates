//
//  WebServices.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation


final class WebServices{
	
	func fetchExchangeRates(urlString : String? = EndPoint.latest,
		                      parameters: QueryStringValue? = "",
													completion: @escaping (Result<RatesResponse, RequestError>) -> Void){
		
		guard let apiRequest = try? APIURLRequest(urlString: urlString,
																							method: .get,
																							params: parameters,
																							headers: [:]) else { return completion(Result.failure(.badRequest))}
		
		let request = try? RequestExecuter(apiRequest)
		guard let fetchRequest = request else { return completion(Result.failure(.badRequest)) }
		fetchRequest.fireRequest(completionQueue: .global()) { response in
			main {
				completion(response)
			}
		}
		
	}
	
	
}

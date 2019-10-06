//
//  StorageSerive.swift
//  MontlyRates
//
//  Created by Engineer 144 on 26/08/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation


public enum StorageError : Error {
	case dataNil
	case encoderNil
	case decoderNil
	case saveMulfunction
	case unknownError(Error)
	case unknownErrorString(String)
}

class StorageService {
	
	static let encoder = JSONEncoder()
	static let decoder = JSONDecoder()
	static let defaults = UserDefaults.standard
	
	static func saveData<T: Encodable>(data: [T]?,key: String)  throws {
		guard let _data = data else { throw  StorageError.dataNil }
		guard let encodedData = try? encoder.encode(_data) else { throw StorageError.encoderNil }
		defaults.set(encodedData, forKey:key)
	}
	
	static func getData<T: Decodable>(key: String) throws -> [T] {
		guard let decoded = defaults.object(forKey: key) else { throw StorageError.dataNil }
		guard let decodedData = try? decoder.decode([T].self, from: decoded as! Data) else { throw  StorageError.decoderNil }
		return decodedData
	}
}


public extension StorageError {
      	var errorDescription :  String{
		switch self {
		case .dataNil:
			return "Data was empty"
		case .encoderNil:
			return "Encoder was Nil"
		case .decoderNil:
			return "Decoder was Nil"
		case .saveMulfunction:
			return "Save was Nil"
		case .unknownError(let err):
			return "\(err)"
		case .unknownErrorString(let self):
			return self
	
		}
		
	}
}

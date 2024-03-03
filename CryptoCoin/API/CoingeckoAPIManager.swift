//
//  CoingeckoAPIManager.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import Foundation
import Alamofire

class CoingeckoAPIManager {
    
    static let shared = CoingeckoAPIManager()
    
    func fetch<T: Decodable>(_ type: T.Type, api: CoingeckoAPI, completionHandler: @escaping (Result<T, CoingeckoRequestError>) -> Void) {
        AF.request(api.path, parameters: api.parameters).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(let failure):
                guard let response = response.response else { return }
                let statusCode = response.statusCode
                
                if statusCode == 404 { completionHandler(.failure(.incorrectpath)) }
                if statusCode == 429 { completionHandler(.failure(.rateLimit)) }
                if statusCode >= 500 { completionHandler(.failure(.serverError)) }
            }
        }
    }
}

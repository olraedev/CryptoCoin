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
    
    func fetch<T: Decodable>(_ type: T.Type, api: CoingeckoAPI, completionHandler: @escaping (T) -> Void) {
        AF.request(api.path, parameters: api.parameters).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure, response.response?.statusCode)
            }
        }
    }
}

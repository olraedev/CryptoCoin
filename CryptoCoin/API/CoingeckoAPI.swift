//
//  CoingeckoAPI.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import Foundation
import Alamofire

enum CoingeckoAPI {
    case trending
    case search(query: String)
    case market(vsCurrency: String, ids: String, sparkline: String)
    
    var baseURL: String { return "https://api.coingecko.com/api/v3/"}
    
    var path: String {
        switch self {
        case .trending: baseURL + "search/trending"
        case .search: baseURL + "search"
        case .market: baseURL + "coins/markets"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .trending: [:]
        case .search(let query): ["query": query]
        case .market(let vsCurrency, let ids, let sparkline):
            ["vs_currency": vsCurrency, "ids": ids, "sparkline": sparkline]
        }
    }
}

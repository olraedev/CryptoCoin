//
//  Search.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import Foundation

struct CoingeckoSearchData: Decodable {
    let coins: [CoingeckoCoinsData]
}

struct CoingeckoCoinsData: Decodable {
    let id: String
    let name: String
    let symbol: String
    let large: String
}

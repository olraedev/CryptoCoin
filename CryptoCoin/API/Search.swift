//
//  Search.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import Foundation

struct Search: Decodable {
    let coins: [Coin]
}

struct Coin: Decodable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
    let large: String
}

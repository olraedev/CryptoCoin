//
//  CoingeckoTrendingCoinData.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 3/1/24.
//

import Foundation

struct CoingeckoTrendingData: Decodable {
    let coins: [CoinItem]
    let nfts: [NftsItem]
}

struct CoinItem: Decodable {
    let item: CoinInfo
}

struct CoinInfo: Decodable {
    let id: String
    let name: String
    let symbol: String
    let large: String
    let score: Int
    let data: CoinData
}

struct CoinData: Decodable {
    let price: String
    let priceChangePercentage24h: Percentage
    
    enum CodingKeys: String, CodingKey {
        case price
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}

struct Percentage: Decodable {
    let krw: Double
}

struct NftsItem: Decodable {
    let name: String
    let symbol: String
    let thumb: String
    let data: NftsData
}

struct NftsData: Decodable {
    let floorPrice: String
    let floorPricePercentage: String
    
    enum CodingKeys: String, CodingKey {
        case floorPrice = "floor_price"
        case floorPricePercentage = "floor_price_in_usd_24h_percentage_change"
    }
}

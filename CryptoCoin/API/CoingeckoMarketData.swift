//
//  Market.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/28/24.
//

import Foundation

struct CoingeckoMarketData: Decodable {
    let id: String // 코인 ID
    let name: String // 코인 이름
    let symbol: String // 코인 통화 단위
    let image: String // 코인 아이콘
    let currentPrice: Double // 코인 현재가
    let priceChangePercentage24h: Double // 코인 변동폭
    let low24h: Double // 코인 저가
    let high24h: Double // 코인 고가
    let allTimeHigh: Double // 코인 사상 최고가 (신고점)
    let allTimeHighDate: String // 코인 사상 최고가 일자
    let allTimeLow: Double // 코인 사상 최저가
    let allTimeLowDate: String // 코인 사상 최저가 일자
    let lastUpdate: String // 코인 시장 업데이트 시각
    let sparkline: CoingeckoPriceData // 일주일 간 코인 시세 정보
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case image
        case currentPrice = "current_price"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case low24h = "low_24h"
        case high24h = "high_24h"
        case allTimeHigh = "ath"
        case allTimeHighDate = "ath_date"
        case allTimeLow = "atl"
        case allTimeLowDate = "atl_date"
        case lastUpdate = "last_updated"
        case sparkline = "sparkline_in_7d"
    }
}

struct CoingeckoPriceData: Decodable {
    let price: [Double]
}

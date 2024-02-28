//
//  RealmModel.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import Foundation
import RealmSwift

class RmSearchList: Object {
    @Persisted(primaryKey: true) var text: String
    @Persisted var date: Date
    
    @Persisted var coins: List<RmCoinData>
    
    convenience init(text: String, coins: [RmCoinData]) {
        self.init()
        self.text = text
        self.date = Date()
        self.coins.append(objectsIn: coins)
    }
}

class RmCoinData: EmbeddedObject {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var symbol: String
    @Persisted var large: String
    
    convenience init(id: String, name: String, symbol: String, large: String) {
        self.init()
        self.id = id
        self.name = name
        self.symbol = symbol
        self.large = large
    }
}

class RmFavoriteCoinList: Object {
    @Persisted(primaryKey: true) var id: String // 코인 ID
    @Persisted var marketData: RmCoinMarketData?
    @Persisted var updateMarketDate: Date?
    
    convenience init(id: String, marketData: RmCoinMarketData?, updateMarketDate: Date?) {
        self.init()
        self.id = id
        self.marketData = marketData
        self.updateMarketDate = updateMarketDate
    }
}

class RmCoinMarketData: EmbeddedObject {
    @Persisted var name: String // 코인 이름
    @Persisted var symbol: String // 코인 통화 단위
    @Persisted var image: String // 코인 아이콘
    @Persisted var currentPrice: Double // 코인 현재가
    @Persisted var priceChangePercentage24h: Double // 코인 변동폭
    @Persisted var low24h: Double // 코인 저가
    @Persisted var high24h: Double // 코인 고가
    @Persisted var allTimeHigh: Double // 코인 사상 최고가 (신고점)
    @Persisted var allTimeHighDate: Date // 코인 사상 최고가 일자
    @Persisted var allTimeLow: Double // 코인 사상 최저가
    @Persisted var allTimeLowDate: Date // 코인 사상 최저가 일자
    @Persisted var lastUpdate: Date // 코인 시장 업데이트 시각
    @Persisted var sparkline: List<Double?> // 일주일 간 코인 시세 정보
    
    convenience init(name: String, symbol: String, image: String, currentPrice: Double, priceChangePercentage24h: Double, low24h: Double, high24h: Double, allTimeHigh: Double, allTimeHighDate: Date, allTimeLow: Double, allTimeLowDate: Date, lastUpdate: Date, sparkline: [Double]) {
        self.init()
        self.name = name
        self.symbol = symbol
        self.image = image
        self.currentPrice = currentPrice
        self.priceChangePercentage24h = priceChangePercentage24h
        self.low24h = low24h
        self.high24h = high24h
        self.allTimeHigh = allTimeHigh
        self.allTimeHighDate = allTimeHighDate
        self.allTimeLow = allTimeLow
        self.allTimeLowDate = allTimeLowDate
        self.lastUpdate = lastUpdate
        self.sparkline.append(objectsIn: sparkline)
    }
}

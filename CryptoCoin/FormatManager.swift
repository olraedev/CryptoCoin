//
//  FormatManager.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/28/24.
//

import Foundation

class FormatManager {
    
    static let shared = FormatManager()
    
    private let dateFormatter = DateFormatter()
    
    private init() { }
    
    // Date 관련 format
    func stringToDateFormat(_ stringFormatDate: String) -> Date {
        if let result = dateFormatter.date(from: stringFormatDate) { return result }
        return Date()
    }
    
    // API -> Realm
    func responseMarketDataToRealm(_ market: CoingeckoMarketData) -> RmFavoriteCoinIDList {
        let favoriteCoinIDList = RmFavoriteCoinIDList(id: market.id, marketData: nil)
        return favoriteCoinIDList
    }
}

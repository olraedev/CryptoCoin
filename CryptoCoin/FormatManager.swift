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
    private let numberFormatter = NumberFormatter()
    
    private init() { }
    
    // Date 관련 format
    func stringToDateFormat(_ stringFormatDate: String) -> Date {
        if let result = dateFormatter.date(from: stringFormatDate) { return result }
        return Date()
    }
    
    // 현재 시간이랑 얼마나 차이나는지
    func dateIntervalSinceToday(date: Date) -> String {
        let timeInterval = Int(Date().timeIntervalSince(date))
        let day = timeInterval / (60 * 60 * 12)
        
        if day <= 0 { return "Today" }
        return "\(day)일 전"
    }
    
    // 날짜를 원하는 포맷으로 변경
    func dateFormatting(_ date: Date, format: String) -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    // 숫자 관련 format
    func decimal(_ number: Double) -> String {
        numberFormatter.numberStyle = .decimal
        let result = "₩" + (numberFormatter.string(for: number) ?? " ")
        
        return result
    }
    
    func percentage(_ number: Double) -> String {
        let percent = String(format: "%.2f", number) + "%  "
        if number > 0  { return "  +" + percent }
        return "  " + percent
    }
    
    // API -> Realm
    func responseMarketDataToRealm(_ market: CoingeckoMarketData) -> RmFavoriteCoinList {
        let marketData = RmCoinMarketData(name: market.name, symbol: market.symbol, image: market.image, currentPrice: market.currentPrice,
                                          priceChangePercentage24h: market.priceChangePercentage24h, low24h: market.low24h, high24h: market.high24h,
                                          allTimeHigh: market.allTimeHigh, allTimeHighDate: stringToDateFormat(market.allTimeHighDate),
                                          allTimeLow: market.allTimeLow, allTimeLowDate: stringToDateFormat(market.allTimeLowDate),
                                          lastUpdate: stringToDateFormat(market.lastUpdate), sparkline: market.sparkline.price)
        let favoriteCoinIDList = RmFavoriteCoinList(id: market.id, marketData: marketData, updateMarketDate: Date())
        return favoriteCoinIDList
    }
}

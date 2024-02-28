//
//  ChartItemAtSection.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/28/24.
//

import UIKit

enum ChartItem: CaseIterable {
    case high
    case low
    case ath
    case atl
    
    var title: String {
        switch self {
        case .high: "고가"
        case .low: "저가"
        case .ath: "신고점"
        case .atl: "신저점"
        }
    }
    
    var color: UIColor {
        switch self {
        case .high, .ath: Design.Color.customRed.fill
        case .low, .atl: Design.Color.customBlue.fill
        }
    }
    
    func returnValue(_ item: RmCoinMarketData?) -> String {
        guard let item else { return "" }
        
        switch self {
        case .high: return FormatManager.shared.decimal(item.high24h)
        case .low: return FormatManager.shared.decimal(item.low24h)
        case .ath: return FormatManager.shared.decimal(item.allTimeHigh)
        case .atl: return FormatManager.shared.decimal(item.allTimeLow)
        }
    }
}

//
//  TrendingSection.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/29/24.
//

import Foundation

enum TrendingSection: Int, CaseIterable {
    case favorite
    case top15Coin
    case top7NFT
    
    var headerTitle: String {
        switch self {
        case .favorite: "My Favorite"
        case .top15Coin: "Top15 Coin"
        case .top7NFT: "Top7 NFT"
        }
    }
    
    var height: CGFloat {
        switch self {
        case .favorite: 150
        case .top15Coin: 200
        case .top7NFT: 200
        }
    }
}

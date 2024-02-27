//
//  RealmModel.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import Foundation
import RealmSwift

class SearchList: Object {
    @Persisted(primaryKey: true) var text: String
    @Persisted var date: Date
    
    @Persisted var coins: List<SearchCoin>
    
    convenience init(text: String, coins: [SearchCoin]) {
        self.init()
        self.text = text
        self.date = Date()
        self.coins.append(objectsIn: coins)
    }
}

class SearchCoin: EmbeddedObject {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var symbol: String
    @Persisted var thumb: String
    @Persisted var large: String
    
    convenience init(id: String, name: String, symbol: String, thumb: String, large: String) {
        self.init()
        self.id = id
        self.name = name
        self.symbol = symbol
        self.thumb = thumb
        self.large = large
    }
}

//
//  RealmManager.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/29/24.
//

import Foundation

class RealmManager {
    
    static let shared = RealmManager()
    
    private let repository = RealmRepository()
    
    func requestToCoingecko(completionHandler: @escaping () -> Void) {
        guard let repository else { return }
        
        // 마켓 정보 없으면 찾기
        var ids: [String] = []
        repository.readEmptyMarketDataList().forEach { list in ids.append(list.id) }
        
        if ids.isEmpty {
            completionHandler()
            return
        }
        
        let group = DispatchGroup()
        
        group.enter()
        CoingeckoAPIManager.shared.fetch([CoingeckoMarketData].self, api: .market(vsCurrency: "krw", ids: ids.joined(separator: ","), sparkline: "true")) { marketData in
            marketData.forEach { value in
                let rmFavoriteCoinList = FormatManager.shared.responseMarketDataToRealm(value)
                repository.updateEmptyMarketDataList(rmFavoriteCoinList)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            completionHandler()
        }
    }
}

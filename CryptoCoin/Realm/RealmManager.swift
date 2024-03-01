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
        
        // 즐겨찾기 목록에서 마켓 정보가 없는 id들 가져오기
        var ids: [String] = []
        repository.readEmptyMarketDataList().forEach { list in ids.append(list.id) }
        
        // 찾을 id가 없는 경우 = 모든 즐겨찾기 항목들이 marketdata를 가지고있음
        if ids.isEmpty {
            completionHandler()
            return
        }
        
        // 마켓 정보가 없는 id 가져오기!
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

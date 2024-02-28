//
//  FavoriteViewModel.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/28/24.
//

import Foundation

class FavoriteViewModel {
    
    private let repository = RealmRepository()
    
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    
    var outputFavoriteList: Observable<[RmFavoriteCoinList]> = Observable([])
    
    init() {
        inputViewWillAppearTrigger.bind { _ in
            self.requestToCoingecko()
        }
    }
    
    private func requestToCoingecko() {
        guard let repository else { return }
        
        // 마켓 정보 없으면 찾기
        var ids: [String] = []
        repository.readEmptyMarketDataList().forEach { list in ids.append(list.id) }
        
        if ids.isEmpty {
            outputFavoriteList.value = repository.readAll(RmFavoriteCoinList.self)
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
            self.outputFavoriteList.value = repository.readAll(RmFavoriteCoinList.self)
        }
    }
}

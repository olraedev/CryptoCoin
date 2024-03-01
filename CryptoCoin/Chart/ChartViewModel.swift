//
//  ChartViewModel.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/28/24.
//

import Foundation

class ChartViewModel {
    
    private let repository = RealmRepository()
    
    var inputID: Observable<String?> = Observable(nil)
    var inputFavoriteButtonTrigger: Observable<Void?> = Observable(nil)
    
    var outputCoinMarketData: Observable<RmCoinMarketData?> = Observable(nil)
    var outputFavoriteState = Observable(false)
    var outputFavoriteButtonClickedState: Observable<FavoriteButtonClickedState> = Observable(.append)
    
    init() {
        inputID.bind { id in
            self.setFavoriteState()
            self.fetchData()
        }
        
        inputFavoriteButtonTrigger.bind { _ in
            self.favoriteButtonClicked()
        }
    }
    
    // 즐겨찾기 버튼 클릭 시
    private func favoriteButtonClicked() {
        guard let id = inputID.value else { return }
        
        RealmManager.shared.favoriteButtonClicked(id) { state in
            self.outputFavoriteButtonClickedState.value = state
            self.setFavoriteState()
        }
    }
    
    private func setFavoriteState() {
        guard let id = inputID.value else { return }
        guard let repository else { return }
        
        if let _ = repository.readForPrimaryKey(RmFavoriteCoinList.self, primaryKey: id) {
            outputFavoriteState.value = true
        } else {
            outputFavoriteState.value = false
        }
    }
    
    private func fetchData() {
        guard let id = inputID.value else { return }
        guard let repository else { return }
        
        // 즐겨 찾기에 있냐 없냐
        if let value = repository.readForPrimaryKey(RmFavoriteCoinList.self, primaryKey: id) {
            // 즐겨찾기에 있고, marketData도 있는 경우 -> 즐겨찾기 탭에서 온 경우
            if let marketData = value.marketData {
                self.outputCoinMarketData.value = marketData
            } 
            
            // 즐겨찾기에는 있지만 marketData가 없는 경우 -> 검색 탭에서 즐겨 찾기 누르고 바로 온 경우
            else {
                let group = DispatchGroup()
                
                group.enter()
                CoingeckoAPIManager.shared.fetch([CoingeckoMarketData].self,
                                                 api: .market(vsCurrency: "krw", ids: id, sparkline: "true")) { responseMarketData in
                    let rmFavoriteCoinList = FormatManager.shared.responseMarketDataToRealm(responseMarketData[0])
                    repository.updateEmptyMarketDataList(rmFavoriteCoinList)
                    group.leave()
                }
                
                group.notify(queue: .main) {
                    self.outputCoinMarketData.value = repository.readForPrimaryKey(RmFavoriteCoinList.self, primaryKey: id)?.marketData
                }
            }
            return
        }
        
        // 즐겨찾기에 없는 경우 -> 검색 탭에서 온 경우
        CoingeckoAPIManager.shared.fetch([CoingeckoMarketData].self,
                                         api: .market(vsCurrency: "krw", ids: id, sparkline: "true")) { responseMarketData in
            self.outputCoinMarketData.value = FormatManager.shared.responseMarketDataToRealm(responseMarketData[0]).marketData
        }
    }
}
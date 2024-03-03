//
//  ChartViewModel.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/28/24.
//

import Foundation

class ChartViewModel {
    
    private let repository = RealmRepository()
    
    var timer = Timer()
    
    var inputID: Observable<String?> = Observable(nil)
    var inputFavoriteButtonTrigger: Observable<Void?> = Observable(nil)
    
    var outputCoinMarketData: Observable<RmCoinMarketData?> = Observable(nil)
    var outputFavoriteState = Observable(false)
    var outputFavoriteButtonClickedState: Observable<FavoriteButtonClickedState?> = Observable(nil)
    var outputRefreshState: Observable<RefreshState?> = Observable(nil)
    var outputError: Observable<CoingeckoRequestError?> = Observable(nil)
    
    init() {
        inputID.bind { id in
            guard let _ = id else { return }
            
            self.setFavoriteState()
            self.fetchData(sender: nil)
            self.setTimer()
        }
        
        inputFavoriteButtonTrigger.bind { _ in
            self.favoriteButtonClicked()
        }
    }
    
    private func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(fetchData(sender:)), userInfo: nil, repeats: true)
    }
    
    // 즐겨찾기 버튼 클릭 시
    private func favoriteButtonClicked() {
        guard let id = inputID.value else { return }
        
        RealmManager.shared.favoriteButtonClicked(id) { state in
            if state == .remove { self.outputCoinMarketData.value = nil }
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
    
    // 불필요한 콜 수 줄이기 위해 45초가 지난 항목만 업데이트
    @objc func fetchData(sender: Timer?) {
        guard let id = inputID.value else { return }
        guard let repository else { return }
        
        // 즐겨 찾기에 있는 항목이냐..?
        // 즐겨 찾기를 해제할 수도 있으니 marketData 유무 확인해야함
        if let value = repository.readForPrimaryKey(RmFavoriteCoinList.self, primaryKey: id) {
            // marketData 있음 -> 45초가 지난 항목인 지 확인
            if let marketData = value.marketData {
                let secondInterval = FormatManager.shared.secondIntervalSinceToday(date: marketData.lastUpdate)
                
                // 45초가 안 지났으니 그냥 냅둬!
                if secondInterval < 45 {
                    self.outputCoinMarketData.value = marketData
                    self.outputRefreshState.value = .alreadyLatest
                    return
                }
            }
            // market 데이터가 없거나, 45초가 지난 경우 market데이터를 불러와야함
            let group = DispatchGroup()
            
            group.enter()
            CoingeckoAPIManager.shared.fetch([CoingeckoMarketData].self,
                                             api: .market(vsCurrency: "krw", ids: id, sparkline: "true")) { result in
                switch result {
                case .success(let responseMarketData):
                    let rmFavoriteCoinList = FormatManager.shared.responseMarketDataToRealm(responseMarketData[0])
                    repository.updateEmptyMarketDataList(rmFavoriteCoinList)
                    self.outputRefreshState.value = .success
                case .failure(let failure):
                    self.outputError.value = failure
                }
                group.leave()
            }
            
            group.notify(queue: .main) {
                self.outputCoinMarketData.value = repository.readForPrimaryKey(RmFavoriteCoinList.self, primaryKey: id)?.marketData
            }
            return
        }
        
        // 즐겨 찾기는 안했지만 이전 항목이 남아있음
        if let value = outputCoinMarketData.value {
            let secondInterval = FormatManager.shared.secondIntervalSinceToday(date: value.lastUpdate)
            
            // 45초가 안 지났으니 그냥 냅둬!
            if secondInterval < 45 {
                self.outputRefreshState.value = .alreadyLatest
                return
            }
        }
        
        // 즐겨 찾기를 안한 항목이냐..?
        CoingeckoAPIManager.shared.fetch([CoingeckoMarketData].self,
                                         api: .market(vsCurrency: "krw", ids: id, sparkline: "true")) { result in
            switch result {
            case .success(let responseMarketData):
                self.outputCoinMarketData.value = FormatManager.shared.responseMarketDataToRealm(responseMarketData[0]).marketData
                self.outputRefreshState.value = .success
            case .failure(let failure):
                self.outputError.value = failure
            }
        }
    }
}

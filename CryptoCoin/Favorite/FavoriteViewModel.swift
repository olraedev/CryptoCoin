//
//  FavoriteViewModel.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/28/24.
//

import Foundation

class FavoriteViewModel {
    
    private let repository = RealmRepository()
    
    var timer = Timer()
    
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var inputRefreshTrigger: Observable<Void?> = Observable(nil)
    
    var outputFavoriteList: Observable<[RmFavoriteCoinList]> = Observable([])
    var outputRefreshState: Observable<RefreshState?> = Observable(nil)
    var outputError: Observable<CoingeckoRequestError?> = Observable(nil)
    
    init() {
        inputViewWillAppearTrigger.bind { value in
            guard let _ = value else { return }
            self.fetch()
            self.setTimer()
        }
        
        inputRefreshTrigger.bind { value in
            guard let _ = value else { return }
            self.refreshFavoriteCoinList(sender: nil)
        }
    }
    
    private func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(refreshFavoriteCoinList(sender:)), userInfo: nil, repeats: true)
    }
    
    // 불필요한 콜 수 줄이기 위해 45초가 지난 항목만 업데이트
    @objc private func refreshFavoriteCoinList(sender: Timer?) {
        guard let repository else { return }
        
        // 즐겨찾기 목록에서 최종 업데이트 시간이 45초가 지난 항목 가져오기
        var ids: [String] = []
        repository.readAll(RmFavoriteCoinList.self).forEach { list in
            guard let date = list.updateMarketDate else { return }
            let secondInterval = FormatManager.shared.secondIntervalSinceToday(date: date)
            if 45 < secondInterval {
                ids.append(list.id)
            }
        }
        
        // 45초 지난 항목이 아무것도 없으면,,
        if ids.count == 0 {
            self.outputRefreshState.value = .alreadyLatest
            return
        }
        
        // id들 요청하기
        let group = DispatchGroup()
        
        group.enter()
        CoingeckoAPIManager.shared.fetch([CoingeckoMarketData].self, api: .market(vsCurrency: "krw", ids: ids.joined(separator: ","), sparkline: "true")) { result in
            switch result {
            case .success(let marketData):
                marketData.forEach { value in
                    let rmFavoriteCoinList = FormatManager.shared.responseMarketDataToRealm(value)
                    repository.updateEmptyMarketDataList(rmFavoriteCoinList)
                }
                self.outputRefreshState.value = .success
            case .failure(let failure):
                self.outputError.value = failure
            }
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.outputFavoriteList.value = repository.readAll(RmFavoriteCoinList.self)
        }
    }
    
    private func fetch() {
        guard let repository else { return }
        
        RealmManager.shared.requestToCoingecko {
            self.outputFavoriteList.value = repository.readAll(RmFavoriteCoinList.self)
        }
    }
}

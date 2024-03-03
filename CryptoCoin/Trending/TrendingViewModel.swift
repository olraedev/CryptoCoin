//
//  TrendingViewModel.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 3/1/24.
//

import Foundation

class TrendingViewModel {
    
    private let repository = RealmRepository()
    
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    
    var outputFavoriteList: Observable<[RmFavoriteCoinList]> = Observable([])
    var outputCoinRankList: Observable<[CoinItem]> = Observable([])
    var outputNftRankList: Observable<[NftsItem]> = Observable([])
    var outputError: Observable<CoingeckoRequestError?> = Observable(nil)
    
    init() {
        inputViewWillAppearTrigger.bind { _ in
            self.fetch()
        }
    }
    
    private func fetch() {
        guard let repository else { return }
        
        RealmManager.shared.requestToCoingecko {
            self.outputFavoriteList.value = repository.readAll(RmFavoriteCoinList.self)
        }

        CoingeckoAPIManager.shared.fetch(CoingeckoTrendingData.self, api: .trending) { result in
            switch result {
            case .success(let success):
                self.outputCoinRankList.value = success.coins
                self.outputNftRankList.value = success.nfts
            case .failure(let failure):
                self.outputError.value = failure
            }
        }
    }
}

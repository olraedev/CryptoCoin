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
            self.fetch()
        }
    }
    
    private func fetch() {
        guard let repository else { return }
        
        RealmManager().requestToCoingecko {
            self.outputFavoriteList.value = repository.readAll(RmFavoriteCoinList.self)
        }
    }
}

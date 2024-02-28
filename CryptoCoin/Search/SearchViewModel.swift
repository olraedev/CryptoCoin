//
//  SearchViewModel.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import Foundation

class SearchViewModel {
    
    let repository = RealmRepository()
    
    var inputSearchText: Observable<String?> = Observable(nil)
    var inputCancelButtonTrigger: Observable<Void?> = Observable(nil)
    var inputFavoriteButtonTrigger: Observable<String?> = Observable(nil)
    
    var outputSearchList: Observable<[CoingeckoCoinsData]> = Observable([])
    var outputSearchState = Observable(true)
    var outputFavoriteListIDs: Observable<[String]> = Observable([])
    var outputFavoriteState: Observable<FavoriteButtonClickedState> = Observable(.append)
    
    init() {        
        guard let repository else { return }
        
        inputSearchText.bind { text in
            self.validation(text)
        }
        
        inputCancelButtonTrigger.bind { _ in
            self.outputSearchList.value.removeAll()
        }
        
        inputFavoriteButtonTrigger.bind { id in
            self.favoriteButtonClicked(id)
        }
        
        repository.readAll(RmFavoriteCoinList.self).forEach { list in
            self.outputFavoriteListIDs.value.append(list.id)
        }
    }
    
    // 즐겨찾기 버튼 클릭 시
    private func favoriteButtonClicked(_ id: String?) {
        guard let id else { return }
        guard let repository else { return }
        
        // 이미 즐겨찾기 한 코인이면 즐겨찾기 목록에서 삭제하기
        if let value = repository.readForPrimaryKey(RmFavoriteCoinList.self, primaryKey: id) {
            outputFavoriteListIDs.value.remove(at: outputFavoriteListIDs.value.firstIndex(of: id)!)
            outputFavoriteState.value = .remove
            repository.delete(objects: value)
        } else {
            // 즐겨찾기는 10개까지 ㅎㅎ
            let favoriteList = repository.readAll(RmFavoriteCoinList.self)
            if favoriteList.count == 10 {
                outputFavoriteState.value = .full
                return
            }
            // 즐겨찾기 목록에 추가하기
            repository.create(objects: RmFavoriteCoinList(id: id, marketData: nil, updateMarketDate: nil))
            outputFavoriteListIDs.value.append(id)
            outputFavoriteState.value = .append
        }
    }
    
    // 입력된 text 확인
    private func validation(_ text: String?) {
        guard let text = text else { return }
        
        // 빈 값
        if text.isEmpty { outputSearchList.value = [] }
        
        let pattern = "[!@#$%^&*()-=+]"
        let regex = try? NSRegularExpression(pattern: pattern)
        
        // 띄어쓰기 하나로 합쳐주기
        let noSpacingText = text.replacingOccurrences(of: " ", with: "")
        
        // 특수문자가 들어 있는 경우
        if let _ = regex?.firstMatch(in: noSpacingText, options: [], range: NSRange(location: 0, length: noSpacingText.count)) {
            outputSearchState.value = false
            return
        }
        
        outputSearchState.value = true
        didSearched(text: noSpacingText.lowercased())
    }
    
    // 15분 업데이트 간격 안에 똑같은 검색어로 입력했을 경우, 굳이 API request를 할 이유가 없음
    private func didSearched(text: String) {
        guard let repository else { return }
        
        // 검색어가 있을 경우 (소문자로만 저장)
        if let value = repository.readForPrimaryKey(RmSearchList.self, primaryKey: text) {
            let timeInterval = Int(Date().timeIntervalSince(value.date))
            let minute = timeInterval / 60

            // 15분 안 지남
            if minute < 15 {
                print("검색어 \(text)는 검색한 지 15분 안 지남, \(minute)분 지남")
                // 일단 삭제
                self.outputSearchList.value.removeAll()
                // 현재 저장되어 있는 coins 빼와서 outputSearchList에 넣어주기
                value.coins.forEach { coin in
                    let coin = CoingeckoCoinsData(id: coin.id, name: coin.name, symbol: coin.symbol, large: coin.large)
                    self.outputSearchList.value.append(coin)
                }
                return
            } else {
                print("검색어 \(text)는 검색한 지 \(minute)분 지나서 다시 불러옵니다")
                repository.delete(objects: value)
            }
        }
        
        // 15분이 지났거나, 검색어가 없는 경우
        requestToCoingecko(query: text)
    }
    
    // request to Coingecko
    private func requestToCoingecko(query: String) {
        let group = DispatchGroup()
        
        group.enter()
        CoingeckoAPIManager.shared.fetch(CoingeckoSearchData.self, api: .search(query: query)) { searchList in
            self.outputSearchList.value = searchList.coins
            group.leave()
        }
        
        group.notify(queue: .main) {
            // create 해주기
            guard let repository = self.repository else { return }
            
            var coins: [RmCoinData] = []
            self.outputSearchList.value.forEach { coin in
                coins.append(RmCoinData(id: coin.id, name: coin.name, symbol: coin.symbol, large: coin.large))
            }
            
            let searchList = RmSearchList(text: query, coins: coins)
            repository.create(objects: searchList)
        }
    }
}

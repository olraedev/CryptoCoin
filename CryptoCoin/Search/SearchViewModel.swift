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
    
    var outputSearchList: Observable<[CoingeckoCoin]> = Observable([])
    var outputSearchState = Observable(true)
    
    init() {
        inputSearchText.bind { text in
            self.validation(text)
        }
        
        inputCancelButtonTrigger.bind { _ in
            self.outputSearchList.value.removeAll()
        }
    }
    
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
        didSearched(text: noSpacingText)
    }
    
    // 15분 업데이트 간격 안에 똑같은 검색어로 입력했을 경우, 굳이 API request를 할 이유가 없음
    private func didSearched(text: String) {
        guard let repository else { return }
        
        // 검색어가 있을 경우
        if let value = repository.readForPrimaryKey(SearchList.self, primaryKey: text) {
            let timeInterval = Int(Date().timeIntervalSince(value.date))
            let minute = timeInterval / 60

            // 15분 안 지남
            if minute <= 15 {
                print("15분 안 지남, \(minute)분 지남")
                // 일단 삭제
                self.outputSearchList.value.removeAll()
                // 현재 저장되어 있는 coins 빼와서 outputSearchList에 넣어주기
                value.coins.forEach { coin in
                    let coin = CoingeckoCoin(id: coin.id, name: coin.name, symbol: coin.symbol, thumb: coin.thumb, large: coin.large)
                    self.outputSearchList.value.append(coin)
                }
                return
            } else {
                print("15분 지남, \(minute)분 지남")
                repository.delete(objects: value)
            }
        }
        
        // 15분이 지났거나, 검색어가 없는 경우
        fetch(query: text)
    }
    
    private func fetch(query: String) {
        let group = DispatchGroup()
        
        group.enter()
        CoingeckoAPIManager.shared.fetch(Search.self, api: .search(query: query)) { searchList in
            self.outputSearchList.value = searchList.coins
            group.leave()
        }
        
        group.notify(queue: .main) {
            // create 해주기
            guard let repository = self.repository else { return }
            
            var coins: [SearchCoin] = []
            self.outputSearchList.value.forEach { coin in
                coins.append(SearchCoin(id: coin.id, name: coin.name, symbol: coin.symbol, thumb: coin.thumb, large: coin.large))
            }
            
            let searchList = SearchList(text: query, coins: coins)
            repository.create(objects: searchList)
        }
    }
}

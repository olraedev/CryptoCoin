//
//  SearchViewModel.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import Foundation

class SearchViewModel {
    
    var inputSearchText: Observable<String?> = Observable(nil)
    var inputCancelButtonTrigger: Observable<Void?> = Observable(nil)
    
    var outputSearchList: Observable<[Coin]> = Observable([])
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
        fetch(query: noSpacingText)
    }
    
    private func fetch(query: String) {
        CoingeckoAPIManager.shared.fetch(Search.self, api: .search(query: query)) { searchList in
            self.outputSearchList.value = searchList.coins
        }
    }
}

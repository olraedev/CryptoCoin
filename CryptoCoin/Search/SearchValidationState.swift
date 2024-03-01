//
//  SearchTextValidationState.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 3/1/24.
//

import Foundation

enum SearchValidationState: String {
    case success
    case includeSpecialCharacters = "검색어에 특수문자를 포함할 수 없습니다"
    case length = "검색어를 10글자 미만으로 입력해주세요"
    case empty = "검색어를 입력해주세요"
}

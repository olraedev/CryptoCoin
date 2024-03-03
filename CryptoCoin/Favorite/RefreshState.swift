//
//  RefreshState.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 3/2/24.
//

import Foundation

enum RefreshState: String {
    case success = "최신 항목으로 업데이트 완료!"
    case alreadyLatest = "이미 최신 항목입니다!"
    case fail = "API 호출에 실패하였습니다"
}

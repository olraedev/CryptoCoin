//
//  CoingeckoRequestError.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 3/3/24.
//

import Foundation

enum CoingeckoRequestError: String, Error {
    case incorrectpath = "Incorrect Path"
    case rateLimit = "요청 제한입니다 잠시 후, 다시 시도하십시오"
    case serverError = "서버 오류"
}

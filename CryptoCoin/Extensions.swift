//
//  Extensions.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import UIKit

extension UIView: ConfigureIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

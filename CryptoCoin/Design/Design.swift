//
//  Color.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import UIKit

enum Design {
    enum Color: String {
        case customBlack
        case customBlue
        case customGray
        case customIndigo
        case customLightGray
        case customPink
        case customPurple
        case customRed
        case customSkyBlue
        case customWhite
        
        var fill: UIColor {
            return UIColor(named: self.rawValue) ?? .customBlack
        }
    }
    
    enum Font: CGFloat {
        case smallest = 15
        case small
        case mid
        case big
        case biggest
        
        var light: UIFont {
            return UIFont.systemFont(ofSize: self.rawValue)
        }
        
        var bold: UIFont {
            return UIFont.boldSystemFont(ofSize: self.rawValue)
        }
    }
}

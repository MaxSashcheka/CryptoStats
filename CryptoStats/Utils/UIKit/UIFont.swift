//
//  UIFont.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 12.02.22.
//

import UIKit

extension UIFont {
    enum Prettiness: String {
        case regular
        case medium
        case bold
    }
    
    enum Font: String {
        case montserrat = "Montserrat"
    }
    
    static func custom(font: Font, size: CGFloat, type: Prettiness) -> UIFont {
        UIFont(name: "\(font.rawValue)-\(type.rawValue.capitalized)", size: size) ?? .systemFont(ofSize: size)
    }
}

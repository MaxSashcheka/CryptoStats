//
//  String.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 12.02.22.
//

import UIKit

extension String {
    func coloredAttributedText(coloredString: String,
                               baseColor: UIColor,
                               color: UIColor,
                               font: UIFont.Font,
                               type: UIFont.Prettiness,
                               size: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self,
                                                         attributes:
                                                            [NSAttributedString.Key.font: UIFont.custom(font: font, size: size, type: type),
                                                             NSAttributedString.Key.foregroundColor: baseColor
                                                         ])
        let coloredAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.custom(font: font, size: size, type: type),
            NSAttributedString.Key.foregroundColor: color
        ]
    
        let range = (self as NSString).range(of: coloredString)
        attributedString.addAttributes(coloredAttribute, range: range)
        return attributedString
    }
}

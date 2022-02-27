//
//  CGSize.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 26.02.22.
//

import UIKit

extension CGSize {
    func increaseWidth(by value: CGFloat) -> Self {
        return Self(width: self.width + value, height: self.height)
    }
    
    func increaseHeight(by value: CGFloat) -> Self {
        return Self(width: self.width, height: self.height + value)
    }
}

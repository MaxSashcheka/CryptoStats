//
//  SettingsCellViewModel.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 15.02.22.
//

import UIKit.UIImage

class SettingsCellViewModel {
    let title: NSAttributedString
    let image: UIImage?
    
    init(title: NSAttributedString, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
    var didSelectClosure: VoidClosure?
}

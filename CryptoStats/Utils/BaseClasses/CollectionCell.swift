//
//  CollectionCell.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 18.02.22.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

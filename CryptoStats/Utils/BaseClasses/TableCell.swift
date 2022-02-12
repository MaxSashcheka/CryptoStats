//
//  TableCell.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import UIKit

class TableCell: UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

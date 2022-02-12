//
//  Storyboarded.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 8.02.22.
//

import UIKit

protocol Storyboarded {
    static func instaniate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instaniate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}

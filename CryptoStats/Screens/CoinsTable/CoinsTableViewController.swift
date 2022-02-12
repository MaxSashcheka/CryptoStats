//
//  ViewController.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 8.02.22.
//

import UIKit

class CoinsTableViewController: ViewController {
    
    var openDetailScreenTransition: VoidClosure?

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .red
    }

    @IBAction func buttonTapped(_ sender: Any) {
        openDetailScreenTransition?()
    }
    
}


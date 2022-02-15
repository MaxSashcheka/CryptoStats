//
//  ViewController.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import UIKit
import RxSwift

class ViewController: UIViewController, Storyboarded {

    let disposeBag = DisposeBag()
    
    var isNavigationBarHidden: Bool { return false }
    var isToolBarHidden: Bool { return true }
    var isTabBarHidden: Bool { return false }
    
    private(set) var isAppearFirstTime = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setToolbarHidden(isToolBarHidden, animated: animated)
        navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: animated)
        tabBarController?.tabBar.isHidden = isTabBarHidden

    }
    
    func bindData() { }
}

//
//  ViewController.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import UIKit
import SnapKit
import RxSwift

class ViewController: UIViewController {
    
    fileprivate var backgroundTransperentView: UIView?
    fileprivate var activityIndicatorContentView: UIView?

    let disposeBag = DisposeBag()
    
    var isNavigationBarHidden: Bool { return false }
    var isToolBarHidden: Bool { return true }
    var isTabBarHidden: Bool { return false }
    var navigationItemTitle: String { return "" }

    private(set) var isAppearFirstTime = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = navigationItemTitle
        navigationController?.setToolbarHidden(isToolBarHidden, animated: animated)
        navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: animated)
        tabBarController?.tabBar.isHidden = isTabBarHidden

    }
    
    func bindData() { }
    
    func showSpinner() {
        if backgroundTransperentView == nil {
            backgroundTransperentView = UIView(frame: self.view.bounds)
            backgroundTransperentView?.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
            
            activityIndicatorContentView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
            activityIndicatorContentView?.center = backgroundTransperentView!.center
            activityIndicatorContentView?.backgroundColor = .white
            activityIndicatorContentView?.layer.opacity = 0.85
            activityIndicatorContentView?.layer.cornerRadius = (activityIndicatorContentView?.frame.height)! / 5
            
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicatorContentView?.addSubview(activityIndicator)

            activityIndicator.startAnimating()
            activityIndicator.snp.makeConstraints { $0.center.equalToSuperview() }
            
            backgroundTransperentView?.addSubview(activityIndicatorContentView!)
 
            
            self.view.insertSubview(backgroundTransperentView!, at: 1)
        }

    }
    
    func removeSpinner() {
        activityIndicatorContentView?.removeFromSuperview()
        backgroundTransperentView?.removeFromSuperview()
        backgroundTransperentView = nil
        activityIndicatorContentView = nil
    }
}

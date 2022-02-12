//
//  SettingsAssembly.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 9.02.22.
//

import Foundation

class SettingsAssembly: Assembly {
    static func makeSettingsScreen() -> SettingsViewController {
        let viewController = SettingsViewController.instaniate()
        
        return viewController
    }
    
}

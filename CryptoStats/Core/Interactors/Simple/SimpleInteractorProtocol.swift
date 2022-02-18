//
//  SimpleInteractorProtocol.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 16.02.22.
//

import Foundation

protocol SimpleInteractorProtocol {
    func getSupportedCurrencies(success: @escaping ([String]) -> Void, failure: @escaping ErrorClosure)
}

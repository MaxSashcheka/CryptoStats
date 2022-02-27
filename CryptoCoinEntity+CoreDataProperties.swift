//
//  CryptoCoinEntity+CoreDataProperties.swift
//  CryptoStats
//
//  Created by Max Sashcheka on 27.02.22.
//
//

import Foundation
import CoreData


extension CryptoCoinEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CryptoCoinEntity> {
        return NSFetchRequest<CryptoCoinEntity>(entityName: "CryptoCoinEntity")
    }

    @NSManaged public var currentPrice: Float
    @NSManaged public var highestPricePerLastDay: Float
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var lowestPricePerLastDay: Float
    @NSManaged public var name: String?
    @NSManaged public var priceChangePercentagePerLastDay: Float
    @NSManaged public var symbol: String?
    @NSManaged public var marketCapRank: Int16
    @NSManaged public var count: Float

}

extension CryptoCoinEntity : Identifiable {

}

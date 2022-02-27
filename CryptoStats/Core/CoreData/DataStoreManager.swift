//
//  DataStoreManager.swift
//  Core Data test
//
//  Created by Max Sashcheka on 26.02.22.
//

import Foundation
import CoreData

class DataStoreManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CryptoStats")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - CRUD
    func createOrUpdateCryptoCoins(_ coins: [CryptoCoin]) throws {
        for coin in coins {
            let coinFetchRequest: NSFetchRequest<CryptoCoinEntity> = CryptoCoinEntity.fetchRequest()
            coinFetchRequest.predicate = NSPredicate(format: "id == %@", coin.id)
            
            let coinEntity: CryptoCoinEntity
            if let fetchedCoinEntity = try viewContext.fetch(coinFetchRequest).first {
                coinEntity = fetchedCoinEntity
            } else {
                coinEntity = CryptoCoinEntity(context: viewContext)
            }
            
            coinEntity.id = coin.id
            coinEntity.symbol = coin.symbol
            coinEntity.name = coin.name
            coinEntity.image = coin.image.absoluteString
            coinEntity.currentPrice = coin.currentPrice
            coinEntity.highestPricePerLastDay = coin.highestPricePerLastDay
            coinEntity.lowestPricePerLastDay = coin.lowestPricePerLastDay
            coinEntity.priceChangePercentagePerLastDay = coin.priceChangePercentagePerLastDay
            coinEntity.marketCapRank = Int16(coin.marketCapRank)
            coinEntity.count = 0.5
            
        }
        
        saveContext()
    }
    
    func updateCryptoCoin(_ coin: CryptoCoin, withCount count: Float) throws {
        let coinFetchRequest: NSFetchRequest<CryptoCoinEntity> = CryptoCoinEntity.fetchRequest()
        coinFetchRequest.predicate = NSPredicate(format: "id == %@", coin.id)
        
        let coinEntity: CryptoCoinEntity
        if let fetchedCoinEntity = try viewContext.fetch(coinFetchRequest).first {
            coinEntity = fetchedCoinEntity
        } else {
            coinEntity = CryptoCoinEntity(context: viewContext)
        }
        coinEntity.count = count
        
        saveContext()
    }
    
    func fetchCryptoCoins() -> [CryptoCoinEntity] {
        let cryptoCoinsFetchRequest: NSFetchRequest<CryptoCoinEntity> = CryptoCoinEntity.fetchRequest()

        if let fetchedCryptoCoins = try? viewContext.fetch(cryptoCoinsFetchRequest) {
            return fetchedCryptoCoins.sorted(by: { $0.marketCapRank < $1.marketCapRank })
        }
        return []
    }
    
//    func deleteMainUser() {
//        let fetchRequest = UserEntity.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "isMain = true")
//
//        if let users = try? viewContext.fetch(fetchRequest) as? [UserEntity], !users.isEmpty {
//            guard let mainUser = users.first else { return }
//            viewContext.delete(mainUser)
//            saveContext()
//        }
//
//
//    }

}

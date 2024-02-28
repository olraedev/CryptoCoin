//
//  RealmRepository.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import Foundation
import RealmSwift

class RealmRepository {
    
    private let realm: Realm
    
    init?() {
        self.realm = try! Realm()
        print(realm.configuration.fileURL!)
    }
    
    // Create
    func create<T: Object>(objects: T) {
        do {
            try realm.write {
                realm.add(objects)
            }
        } catch {
            print("\(objects) create ERROR: \(error)")
        }
    }
    
    // Read
    func readAll<T: Object>(_ type: T.Type) -> [T] {
        return Array(realm.objects(T.self))
    }
    
    func readForPrimaryKey<T: Object>(_ type: T.Type, primaryKey: String) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: primaryKey)
    }
    
    func readEmptyMarketDataList() -> Results<RmFavoriteCoinList> {
        return realm.objects(RmFavoriteCoinList.self).where { $0.marketData == nil }
    }
    
    // Upadte
    func updateEmptyMarketDataList(_ value: RmFavoriteCoinList) {
        do {
            try realm.write {
                realm.create(RmFavoriteCoinList.self, value: value, update: .modified)
            }
        } catch {
            print("\(#function) ERROR: \(error)")
        }
    }
    
    // Delete
    func delete<T: Object>(objects: T) {
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            print("\(objects) Delete ERROR: \(error)")
        }
    }
}

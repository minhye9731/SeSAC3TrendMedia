//
//  UserShoppingRepository.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 8/28/22.
//

import Foundation
import RealmSwift

protocol UserShoppingRepositoryType {
    
    func sort(_ sort: String) -> Results<UserShoppingList>
    func filter(_ filter: String) -> Results<UserShoppingList>
    
    func addItem(item: UserShoppingList)
    func deleteItem(item: UserShoppingList)
    
    func updateDoneCheck(item: UserShoppingList)
    func updateFavorite(item: UserShoppingList)
    
}

class UserShoppingRepository: UserShoppingRepositoryType {

    let localRealm = try! Realm()
    
    func sort(_ sort: String) -> Results<UserShoppingList> {
        return localRealm.objects(UserShoppingList.self).sorted(byKeyPath: sort, ascending: true)
    }
    
    func filter(_ filter: String) -> Results<UserShoppingList> {
        return localRealm.objects(UserShoppingList.self).filter("\(filter) == true")
    }
    
    func addItem(item: UserShoppingList) {
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteItem(item: UserShoppingList) {
        
        do {
            removeImageFromDocument(fileName: "\(item.objectId).jpg")
            try localRealm.write {
                localRealm.delete(item)
            }
        } catch let error {
            print(error)
        }
    }
    
    
    func updateDoneCheck(item: UserShoppingList) {
        do {
            try localRealm.write {
                item.doneCheck.toggle()
            }
        } catch let error {
            print(error)
        }
    }
    
    func updateFavorite(item: UserShoppingList) {
        do {
            try localRealm.write {
                item.favorite.toggle()
            }
        } catch let error {
            print(error)
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로. 이미지를 저장할 위치
    
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
}

//
//  ManagRealm.swift
//  VkBox
//
//  Created by Rayen on 10/16/20.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    private let networkManager = NetworkManager()
    func updateFriends() {
        
        networkManager.fetchRequestFriends { friends in
            
            do {
                
                let realm = try Realm()
                let oldValue = realm.objects(User.self)
                
                realm.beginWrite()
                realm.delete(oldValue)
                realm.add(friends)
                
                try realm.commitWrite()
            } catch {
                
                print(error)
            }
        }
    }
    
    func updateGroups() {
        
        networkManager.fetchRequestGroupsUser { groups in
            
            do {
                
                let realm = try Realm()
                let oldValue = realm.objects(Group.self)
                
                realm.beginWrite()
                realm.delete(oldValue)
                realm.add(groups)
                
                try realm.commitWrite()
            } catch {
                
                print(error)
            }
        }
    }
    
    func updatePhotos(for userId: Int?) {
        
        networkManager.fetchRequestPhotosUser(for: userId) { photos in
            
            do {
                
                let realm = try Realm()
                let oldValue = realm.objects(Photo.self)
                
                realm.beginWrite()
                realm.delete(oldValue)
                realm.add(photos)
                
                try realm.commitWrite()
            } catch {
                
                print(error)
            }
        }
    }
}

//
//  User.swift
//  VK Client
//
//  Created by Rayen D on 06.09.2020.
//  Copyright © 2020 Rayen D. All rights reserved.
//


import Foundation
import RealmSwift
class User: Object, Decodable {
    
    @objc dynamic var id = 0
    @objc dynamic var firstName: String? = nil
    @objc dynamic var lastName: String? = nil
    @objc dynamic var photo100: String? = nil
    
    func returnFullName() -> String? {

        return "\(firstName ?? "") \(lastName ?? "")"
   }
    
    override static func primaryKey() -> String? {
       return "id"
   }

    override static func indexedProperties() -> [String] {
       return ["firstName", "lastName"]
   }
}


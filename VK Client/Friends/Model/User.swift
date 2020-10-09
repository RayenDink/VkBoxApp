//
//  User.swift
//  VK Client
//
//  Created by Rayen D on 06.09.2020.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import Foundation
import RealmSwift
class User: Decodable {
    
    @objc dynamic var id = 0
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    @objc dynamic var photo100: String?
    
    func returnFullName() -> String? {

        return "\(firstName ?? "") \(lastName ?? "")"
   }
}


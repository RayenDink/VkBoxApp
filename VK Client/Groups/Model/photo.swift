//
//  photo.swift
//  VkBox
//
//  Created by Rayen on 10/9/20.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import Foundation
import RealmSwift
class Photo: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var ownerId = 0
    var sizes = List<Sizes>()
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["ownerId"]
    }
}

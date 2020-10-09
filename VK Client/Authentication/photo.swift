//
//  photo.swift
//  VkBox
//
//  Created by Rayen on 10/9/20.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import Foundation
 import RealmSwift

class Group: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var name: String?
    @objc dynamic var photo50: String?

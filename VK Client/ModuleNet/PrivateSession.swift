//
//  PrivSession.swift
//  VkBox
//
//  Created by Rayen on 9/25/20.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import Foundation

class Session {
    
    static let shared = Session()
    
    var token: String?
    var userId: Int?
    
    private init(){}
}

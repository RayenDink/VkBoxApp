//
//  Item.swift
//  VkBox
//
//  Created by Rayen on 10/5/20.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import Foundation

  class Items<T: Decodable>: Decodable {

      let items: [T]?
  }

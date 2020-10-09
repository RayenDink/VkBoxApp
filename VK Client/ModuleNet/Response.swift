//
//  react.swift
//  VkBox
//
//  Created by Rayen on 10/5/20.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import Foundation

  class Response<T: Decodable>: Decodable {

      let response: Items<T>?
 }

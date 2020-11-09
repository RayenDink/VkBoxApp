//
//   DateFormat.swift
//  VkBox
//
//  Created by Rayen on 11/9/20.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import Foundation
import UIKit

class DateFormat {

    let dateFormat = DateFormat()

    func convertDate(timeIntervalSince1970: Double) -> String{
        dateFormat.dateFormat = "MM-dd-yyyy HH.mm"
        dateFormat.timeZone = TimeZone(abbreviation: "UTC")
        let date = Date(timeIntervalSince1970: timeIntervalSince1970)
        return dateFormat.string(from: date)
    }
}

//
//  AvailableGroupsController.swift
//  VK Client
//
//  Created by Rayen D on 06.09.2020.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import UIKit

class AvailableGroupsController: UITableViewController {
    
// Дефолтный массив:
var allGroups = [Group(nameGroup: "[BadComedian]", imageGroup: "[BadComedian]"),
                       Group(nameGroup: "Десигн", imageGroup: "Десигн"),
                       Group(nameGroup: "Вестник нищеброда", imageGroup: "Вестник нищеброда"),
                       Group(nameGroup: "CocoaHeads Russia", imageGroup: "CocoaHeads Russia"),
                       Group(nameGroup: "SwiftBook", imageGroup: "SwiftBook"),
                       Group(nameGroup: "sndk", imageGroup: "sndk")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableGroupsCell", for: indexPath) as! AvailableGroupsCell
        let allGroup = allGroups[indexPath.row]
        
        cell.configure(for: allGroup)
        
        return cell
    }
    
}

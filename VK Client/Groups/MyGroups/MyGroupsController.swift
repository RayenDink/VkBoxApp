//
//  MyGroupsController.swift
//  VK Client
//
//  Created by Rayen D on 06.09.2020.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import UIKit
import RealmSwift

class MyGroupsController: UITableViewController {
    
    // Объявляем экземпляр класса:
    let searchController = UISearchController(searchResultsController: nil)
    let realmManager = RealmManager
    var myGroups: Results<Group>!
    var token: NotificationToken?    // Массив:
    var filteredGroups = [Group]()
    // Свойство определяющее является ли строка пустой или нет:
    var searchBarIsEmpty: Bool {
        
        guard let text = searchController.searchBar.text else { return false }
        
        return text.isEmpty
    }
    // Логическое свойство, которое будет возвращать true в том случае, когда поисковой запрос был активирован:
    var isFiltering: Bool {
        
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableAndRealm()
        setupSearchController()
        fetchRequestGroupsUser()
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addGroup" {
            //            guard let availableGroups = segue.source as? AvailableGroupsController else { return }
            //            if let indexPath = availableGroups.tableView.indexPathForSelectedRow {
            //                let group = availableGroups.allGroups[indexPath.row]
            //
            //                if !myGroups.contains(where: {$0.id == group.id}) {
            //                    myGroups.append(group)
            //                    tableView.reloadData()
            //                } else {
            //                    let alert = UIAlertController(title: "Choose another group",
            //                                                  message: "This group already exists on your list",
            //                                                  preferredStyle: .alert)
            //                    let alertAction = UIAlertAction(title: "OK", style: .cancel)
            //                    alert.addAction(alertAction)
            //
            //                    present(alert, animated: true)
            //                }
            //            }
        }
    }
    
    // MARK: Help Function
    
    func fetchRequestGroupsUser() {
        do {
            let realm = try Realm()
            let groups = realm.objects(Group.self)
            myGroups = groups
        } catch {
            print(error)
        }
    }
    private func bindTableAndRealm() {
        
        guard let realm = try? Realm() else { return }
        
        myGroups = realm.objects(Group.self)
        
        token = myGroups.observe { [weak self] (changes: RealmCollectionChange) in
            
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
                
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0,
                                                                    section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0,
                                                                   section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0,
                                                                       section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
                
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    networkManager.fetchRequestGroupsUser { [weak self] groups in
    
    for group in groups {
    
    self?.myGroups.append(group)
    
    DispatchQueue.main.async {
    self?.tableView.reloadData()
    }
    //                if !myGroups.contains(where: {$0.nameGroup == group.nameGroup}) {
    //                    myGroups.append(group)
    //                    tableView.reloadData()
    //                } else {
    //
    //                    let alert = UIAlertController(title: "Choose another group",
    //                                                  message: "This group already exists on your list",
    //                                                  preferredStyle: .alert)
    //                    let alertAction = UIAlertAction(title: "OK", style: .cancel)
    //                    alert.addAction(alertAction)
    //                    present(alert, animated: true)
    }
    }
}
}

// MARK: - Table view data source

override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if isFiltering {
        return filteredGroups.count
    }
    
    return myGroups.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as! MyGroupsCell
    let myGroup: Group
    
    if isFiltering {
        myGroup = filteredGroups[indexPath.row]
    } else {
        myGroup = myGroups[indexPath.row]
    }
    
    cell.configure(for: myGroup)
    
    return cell
}

override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
        
        if isFiltering {
            
            let filteredGroup = filteredGroups.remove(at: indexPath.row)
            myGroups.removeAll(where: {$0.nameGroup == filteredGroup.nameGroup})
        } else {
            
            myGroups.remove(at: indexPath.row)
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}


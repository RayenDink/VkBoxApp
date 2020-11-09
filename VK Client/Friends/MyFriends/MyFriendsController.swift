//
//  MyFriendsController.swift
//  VK Client
//
//  Created by Rayen D on 06.09.2020.
//  Copyright © 2020 Rayen D. All rights reserved.
//
import UIKit
import RealmSwift

class MyFriendsController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let realmManager = RealmManager()
    var friends: Results<User>!
    //    var friendsSection = [String]()
    //    var friendsDictionary = [String: [User]]()
    var filteredUsers = [User]()
    var token: NotificationToken?
    var searchBarIsEmpty: Bool {
        
        
        guard let text = searchController.searchBar.text else { return false }
        
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRequestFriends()
        setupSearchController()
        tableView.sectionIndexColor = .white
        bindTableAndRealm()
        sortFriend()
    }
    
    // MARK: - Help Function
    
    private func fetchRequestFriends() {
        do {
            let realm = try Realm()
            let friend = realm.objects(User.self)
            friends = friend
        } catch {
            print(error)
        }
        //        DispatchQueue.main.async { [weak self] in
        //
        //            self?.sortFriend()
        //            self?.tableView.reloadData()
        //        }
    }
    
    private func bindTableAndRealm() {
        
        //        for friend in friends {
        //
        //            guard let name = friend.firstName,
        //                  let lastName = friend.lastName else { return }
        //            let fullName = name + " " + lastName
        guard let realm = try? Realm() else { return }
        friends = realm.objects(User.self)
        token = friends.observe { [weak self] (changes: RealmCollectionChange) in
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
                
            //            let key = "\(fullName[fullName.startIndex])"
            //            guard let name = friend.returnFullName() else { return }
            //            let key = "\(name[name.startIndex])"
            
            //            if var friendValue = friendsDictionary[key] {
            //                friendValue.append(friend)
            //                friendsDictionary[key] = friendValue
            //            } else {
            //                friendsDictionary[key] = [friend]
            }
            
            //            friendsSection = [String](friendsDictionary.keys).sorted()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredUsers.count
        }
        return friends.count
        //        let friendKey = friendsSection[section]
        //
        //        if let friend = friendsDictionary[friendKey] {
        //            return friend.count
        //        }
        //        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as! MyFriendsCell
        let myFriend: User
        if isFiltering {
            
            cell.configure(for: filteredUsers[indexPath.row])
        } else {
            myFriend = friends[indexPath.row]
            //            let friendKey = friendsSection[indexPath.section]
            //
            //            if var friendValue = friendsDictionary[friendKey.uppercased()] {
            //
            //                if isFiltering {
            //                    friendValue = filteredUsers
            //                }
            //
            //                cell.selectionStyle = .none
            //                cell.configure(for: friendValue[indexPath.row])
            //            }
        }
        cell.configure(for: myFriend)
        //        return cell
        //    }
        //
        //    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        //        return friendsSection
        //    }
        //
        //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //
        //        if isFiltering {
        //            return ""
        //        }
        //
        //        return friendsSection[section]
        //    }
        //
        //    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //        return 20
        //    }
        //
        //    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //        view.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        //        let header = view as! UITableViewHeaderFooterView
        //
        //        header.alpha = 0.3
        //        header.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        //        header.textLabel?.textAlignment = .left
        //        header.textLabel?.textColor = .white
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addImage" {
            
            let detailFriendController = segue.destination as? DetailFriendController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                if isFiltering {
                    
                    let friends = filteredUsers[indexPath.row]
                    guard let name = friends.firstName,
                          let lastName = friends.lastName else { return }
                    detailFriendController?.fetchRequestPhotosUser(for: friends.id)
                    
                    detailFriendController?.titleItem = name + " " + lastName
                    detailFriendController?.friendsImage.removeAll()
                    detailFriendController?.friendsImage.append(friends)
                } else {
                    
                    //                    let friendKey = friendsSection[indexPath.section]
                    let friend = friends[indexPath.row]
                    
                    guard let name = friend.firstName,
                          let lastName = friend.lastName else { return }
                    
                    detailFriendController?.fetchRequestPhotosUser(for: friend.id)
                    detailFriendController?.titleItem = name + " " + lastName
                    detailFriendController?.ownerID = friend.id
                    
                    //                    if let friendValue = friendsDictionary[friendKey.uppercased()] {
                    //                        let friendsValue = friendValue[indexPath.row]
                    //                        guard let name = friendsValue.firstName,
                    //                              let lastName = friendsValue.lastName else { return }
                    //                        detailFriendController?.fetchRequestPhotosUser(for: friendsValue.id)
                    //                        detailFriendController?.titleItem = name + " " + lastName
                    //                        
                    //                        detailFriendController?.friendsImage.removeAll()
                    //                        detailFriendController?.friendsImage.append(friendsValue)
                    //                    }
                }
            }
        }
    }
}

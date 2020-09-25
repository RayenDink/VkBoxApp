//
//  MyGroupsController+UISearchController.swift
//  VK Client
//
//  Created by Rayen D on 06.09.2020.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import UIKit

extension MyGroupsController: UISearchResultsUpdating {
    
    
    func setupSearchController() {
    
// Получаем инфо об изменении текста:
        searchController.searchResultsUpdater = self
// Запрет взаимодействия с контентом при вводе:
        searchController.obscuresBackgroundDuringPresentation = false
// Название строки поиска:
        searchController.searchBar.placeholder = "Search Groups"
// Расположение:
        navigationItem.searchController = searchController
// Строка поиска при переходе:
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        filteredGroups = myGroups.filter{ (group: Group) -> Bool in
            return group.nameGroup.contains(searchText)
        }
        
        tableView.reloadData()
    }
}

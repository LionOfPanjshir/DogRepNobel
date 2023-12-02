//
//  NobelTableViewController.swift
//  DogRepNobel
//
//  Created by Andrew Higbee on 11/20/23.
//

import UIKit

class NobelTableViewController: UITableViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        getNobel()
    }
    
    var searchController = UISearchController()
    
    var nobel: Nobel?
    var prize: Prize?

    override func viewDidLoad() {
        super.viewDidLoad()

        getNobel()
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.automaticallyShowsSearchResultsController = true
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.scopeButtonTitles = ["Movies", "Music", "Apps", "Books"]
    }

    func getNobel() {
        let nobelRequest = NobelDataAPIRequest()
        
        Task {
            do {
                let nobelData = try await ResultsController.shared.sendRequest(nobelRequest)
                self.nobel = nobelData
                tableView.reloadData()
                print(nobel)
            } catch {
                print(error)
            }
        }
    }
    
    func getPrize() {
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let nobel {
            return nobel.laureates.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nobelCell", for: indexPath) as! UITableViewCell
        guard let nobel else { return cell }
        let laureate = nobel.laureates[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = laureate.fullName.en
        content.secondaryText = laureate.nobelPrizes[0].category.en
        cell.contentConfiguration = content
        return cell
    }
}

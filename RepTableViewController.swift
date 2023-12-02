//
//  RepTableViewController.swift
//  DogRepNobel
//
//  Created by Andrew Higbee on 11/20/23.
//

import UIKit

class RepTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var results = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        getSearchResults()
    }
    
    func getSearchResults() {
        var searchTerms = searchBar.text ?? ""
        
        let searchRequest = RepDataAPIRequest(zipCode: searchTerms)
        
        Task {
            do {
                let searchInfo = try await ResultsController.shared.sendRequest(searchRequest)
                results = searchInfo.results
                print(results)
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repCell", for: indexPath)
        
        let result = results[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = result.name
        content.secondaryText = result.party
        // Configure the cell...
        cell.contentConfiguration = content
        return cell
    }
    
    @IBSegueAction func repDetailSegue(_ coder: NSCoder, sender: Any?) -> RepDetailViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else { return nil }
        
        let result = results[indexPath.row]
        
        return RepDetailViewController(coder: coder, result: result)
    }
}

extension RepTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getSearchResults()
        searchBar.resignFirstResponder()
    }
}

//
//  NobelViewController.swift
//  DogRepNobel
//
//  Created by Andrew Higbee on 11/23/23.
//

import UIKit

class NobelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var prize: Prize?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func getNobelData() {
        guard let segmentInput = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex) else { return }
        var nobelCategory = ""
        switch segmentInput {
        case "Chemistry":
            nobelCategory = "che"
        case "Economics":
            nobelCategory = "eco"
        case "Literature":
            nobelCategory = "lit"
        case "Peace":
            nobelCategory = "pea"
        case "Physics":
            nobelCategory = "phy"
        case "Medicine":
            nobelCategory = "med"
        default:
            nobelCategory = "pea"
        }
        
        let searchYear = searchBar.text ?? ""
        
        let query = [
            "sort": "asc",
            "nobelPrizeYear": searchYear,
            "nobelPrizeCategory": nobelCategory,
            "format": "json",
            "csvLang": "en"
        ]
        
        let prizeRequest = NobelPrizeDataAPIRequest(query: query)
        
        Task {
            do {
                let prizeInfo = try await ResultsController.shared.sendRequest(prizeRequest)
                prize = prizeInfo
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func segmentButtonTapped(_ sender: Any) {
        getNobelData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let prize else { return 0 }
        return (prize.nobelPrizes?[0].laureates.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "prizeCell", for: indexPath) 
        guard let prize else { return cell }
        let laureate = prize.nobelPrizes?[0].laureates[indexPath.row]
        var content = cell.defaultContentConfiguration()
        if let laur =  laureate {
            if let name = laureate?.fullName {
                content.text = name.en
            } else if let org = laureate?.orgName {
                content.text = org.en
            }
        }

        content.secondaryText = laureate?.motivation.en
        cell.contentConfiguration = content
        return cell
    }

}

extension NobelViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getNobelData()
        searchBar.resignFirstResponder()
    }
}

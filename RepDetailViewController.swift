//
//  RepDetailViewController.swift
//  DogRepNobel
//
//  Created by Andrew Higbee on 11/20/23.
//

import UIKit

class RepDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var officeLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    
    var result: Result?
    
    init?(coder: NSCoder, result: Result?) {
        super.init(coder: coder)
        self.result = result
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        guard let result else { return }
        
        if let districNum = Int(result.district) {
            titleLabel.text = "Representative"
        } else {
            titleLabel.text = "Senator"
        }
        nameLabel.text = result.name
        partyLabel.text = result.party
        stateLabel.text = result.state
        districtLabel.text = result.district
        phoneLabel.text = result.phone
        officeLabel.text = result.office
        linkLabel.text = result.link
    }
}

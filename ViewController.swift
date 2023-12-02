//
//  ViewController.swift
//  DogRepNobel
//
//  Created by Andrew Higbee on 11/20/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newImageButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var random: Random?
    var image: UIImage?
    var breeds: Breed?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getImageData()
        //getBreed()
    }
    
    func getImageData() {
        let imageDatRequest = ImageDataAPIRequest()
        
        Task {
            do {
                let imageInfo = try await ResultsController.shared.sendRequest(imageDatRequest)
                self.random = imageInfo
                //print(random)
                Task {
                    do {
                        getImage()
                        getBreed()
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func updateUI() {
        guard let image else { return }
        imageView.image = image
    }

    func getImage() {
        guard let random else { return }
        let url = random.message
        let imageRequest = ImageAPIRequest(url: url)
        //print(imageRequest)
        
        Task {
            do {
                let image = try await ResultsController.shared.sendRequest(imageRequest)
                self.image = image
                updateUI()
            //    print(image)
            } catch {
                print(error)
            }
        }
    }
    
    func getBreed() {
        let breedRequest = BreedAPIRequest()
        
        Task {
            do {
                let dogBreeds = try await ResultsController.shared.sendRequest(breedRequest)
                breeds = dogBreeds
                print(breeds)
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func newImageButtonTap(_ sender: Any) {
        getImageData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let breeds else { return 0 }
        
        return breeds.message.affenpinscher.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedCell", for: indexPath) as! UITableViewCell
        
        let breed = breeds?.message.affenpinscher[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = "Affenpinscher"
        cell.contentConfiguration = content
        return cell
    }
}


//
//  Breed.swift
//  DogRepNobel
//
//  Created by Andrew Higbee on 11/20/23.
//

import Foundation

struct Breed: Codable {
    var message: SubBreed
    var status: String
}

struct SubBreed: Codable {
    var affenpinscher: [String]
}

struct Random: Codable {
    var message: String
    var status: String
}

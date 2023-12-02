//
//  Rep.swift
//  DogRepNobel
//
//  Created by Andrew Higbee on 11/20/23.
//

import Foundation

struct Rep: Codable {
    var results: [Result]
}

struct Result: Codable {
    var name: String
    var party: String
    var state: String
    var district: String
    var phone: String
    var office: String
    var link: String
}

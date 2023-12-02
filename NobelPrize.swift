//
//  NobelPrize.swift
//  DogRepNobel
//
//  Created by Andrew Higbee on 11/22/23.
//

import Foundation

struct Prize: Codable {
    var nobelPrizes: [Details]?
}

struct Details: Codable {
    var awardYear: String
    var category: Cat
    var dateAwarded: String
    var prizeAmount: Int
    var laureates: [Laur]
    
}

struct Cat: Codable {
    var en: String
}

struct Laur: Codable {
    var knownName: KnownNames?
    var fullName: FullNames?
    var orgName: OrgName?
    var motivation: Motiv
}

struct KnownNames: Codable {
    var en: String
}

struct FullNames: Codable {
    var en: String
}

struct OrgName: Codable {
    var en: String
}

struct Motiv: Codable {
    var en: String
}

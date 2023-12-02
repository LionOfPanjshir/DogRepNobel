//
//  Nobel.swift
//  DogRepNobel
//
//  Created by Andrew Higbee on 11/20/23.
//

import Foundation

struct Nobel: Codable {
    var laureates: [Laureate]
}

struct Laureate: Codable {
    var id: String
    var knownName: KnownName
    var givenName: GivenName
    var familyName: FamilyName
    var fullName: FullName
    var fileName: String
    var birth: Birth
    var nobelPrizes: [NobelPrize]
}

struct KnownName: Codable {
    var en: String
    var se: String
}

struct GivenName: Codable {
    var en: String
}

struct FamilyName: Codable {
    var en: String
}

struct FullName: Codable {
    var en: String
}

struct Birth: Codable {
    var date: String
    var place: Place?
}

struct Place: Codable {
    var city: City
    var country: Country
    var cityNow: CityNow
    var countryNow: CountryNow
}

struct City: Codable {
    var en: String
}

struct Country: Codable {
    var en: String
}
struct CityNow: Codable {
    var en: String
}

struct CountryNow: Codable {
    var en: String
}

struct NobelPrize: Codable {
    var awardYear: String
    var category: Category
    var categoryFullName: CategoryFullName
    var dateAwarded: String?
    var motivation: Motivation
}

struct Category: Codable {
    var en: String
}

struct CategoryFullName: Codable {
    var en: String
}

struct Motivation: Codable {
    var en: String
}

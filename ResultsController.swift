//
//  ResultsController.swift
//  DogRepNobel
//
//  Created by Andrew Higbee on 11/20/23.
//

import Foundation
import UIKit

class ResultsController {
    static var shared = ResultsController()
    
    func sendRequest<Request: APIRequest>(_ request: Request) async throws -> Request.Response {
        let (data, response) = try await URLSession.shared.data(for: request.urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw APIRequestError.itemNotFound }
        
        let decodedResponse = try request.decodeResponse(data: data)
        return decodedResponse
    }
}

protocol APIRequest {
    associatedtype Response
    
    var urlRequest: URLRequest { get }
    func decodeResponse(data: Data) throws -> Response
}

enum APIRequestError: Error {
    case itemNotFound
}

struct BreedAPIRequest: APIRequest {
    
    typealias Response = Breed
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: "https://dog.ceo/api/breeds/list/all")!
        return URLRequest(url: urlComponents.url!)
    }
    
        func decodeResponse(data: Data) throws -> Breed {
            let searchInfo = try JSONDecoder().decode(Breed.self, from: data)
            return searchInfo
        }
    
}

struct ImageDataAPIRequest: APIRequest {
    typealias Response = Random
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: "https://dog.ceo/api/breeds/image/random")!
        return URLRequest(url: urlComponents.url!)
    }
    
    func decodeResponse(data: Data) throws -> Random {
        let searchInfo = try JSONDecoder().decode(Random.self, from: data)
        return searchInfo
    }
}

struct ImageAPIRequest: APIRequest {
    typealias Response = UIImage
    
    let url: String
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: url)!
        return URLRequest(url: urlComponents.url!)
    }
    
    enum ResponseError: Error {
        case invalidImageData
    }
    
    func decodeResponse(data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else { throw ResponseError.invalidImageData }
        return image
    }
}

struct RepDataAPIRequest: APIRequest {
    typealias Response = Rep
    
    var zipCode: String
    
    var urlRequest: URLRequest {
        let urlComponents = URLComponents(string: "https://whoismyrepresentative.com/getall_mems.php?zip=" + zipCode + "&output=json")!
        return URLRequest(url: urlComponents.url!)
    }
    
    func decodeResponse(data: Data) throws -> Rep {
        let searchInfo = try JSONDecoder().decode(Rep.self, from: data)
        return searchInfo
    }
    
}

struct NobelDataAPIRequest: APIRequest {
    typealias Response = Nobel
    
    var urlRequest: URLRequest {
        let urlComponents = URLComponents(string: "https://api.nobelprize.org/2.1/laureates")!
        return URLRequest(url: urlComponents.url!)
    }
    
    func decodeResponse(data: Data) throws -> Nobel {
        let searchInfo = try JSONDecoder().decode(Nobel.self, from: data)
        return searchInfo
    }
}

struct NobelPrizeDataAPIRequest: APIRequest {
    typealias Response = Prize
    
    var query: [String: String]
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: "https://api.nobelprize.org/2.1/nobelPrizes")!
        urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value)}
        return URLRequest(url: urlComponents.url!)
    }
    
    func decodeResponse(data: Data) throws -> Prize {
        let NobelInfo = try JSONDecoder().decode(Prize.self, from: data)
        return NobelInfo
    }
}

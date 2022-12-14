//
//  APIManager.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import Foundation
import Combine

enum QueryType: String {
    case searchByTitle = "s"
    case searchById = "i"
}

class APIManager {
    
    static let apiHost = "www.ombdapi"
    
    private func buildRequestUrl(queryType query: QueryType, with string: String) -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = APIManager.apiHost
        urlComponents.path = "/"
        
        urlComponents.queryItems = [
            URLQueryItem(name: query.rawValue, value: string),
            URLQueryItem(name: "apikey", value: "b620043c")
        ]
        
        return urlComponents.url
    }
}

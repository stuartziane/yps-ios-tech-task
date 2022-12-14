//
//  SearchResult.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import Foundation

/*
    This is the model used for the search result.
*/

struct SearchResult: Codable {
    let search: [SearchResultItem]?
    let totalResults: String?
    let response: String?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
}

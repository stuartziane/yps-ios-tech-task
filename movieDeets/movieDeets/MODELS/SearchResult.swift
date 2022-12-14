//
//  SearchResult.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import Foundation


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

struct SearchResultItem: Codable {
    let title: String?
    let year: String?
    let imdbID: String?
    let type: String?
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

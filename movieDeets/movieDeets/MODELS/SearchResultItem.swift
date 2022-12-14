//
//  SearchResultItem.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import Foundation

//  Model used for the items in the search results

struct SearchResultItem: Codable, Identifiable, Hashable {
    let id = UUID()
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

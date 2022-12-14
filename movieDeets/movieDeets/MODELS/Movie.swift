//
//  Movie.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//


import Foundation

/*
 This is the model used for the detail view, when looking up a movie by imdbID.  Of note is the fact that everything is optional, except for response.
 I tried playing around to find out what was returned in each JSON object, but movies and tv shows have different keys in them.
*/


struct Movie: Identifiable, Codable, Hashable {
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    
    var id = UUID()
    let title: String
    let year: String
    let rated: String?
    let released: String?
    let imdbID: String?
    let type: String
    let dvd: String?
    let boxOffice: String?
    let production: String?
    let actors: String?
    let plot: String
    let language: String?
    let country: String?
    let awards: String?
    let poster: String?
    let metascore: String?
    let runtime: String?
    let genre: String?
    let director: String?
    let writer: String?
    let imdbRating: String?
    let imdbVotes: String?
    let website: String?
    let totalSeasons: String?
    let response: String
    
    let ratings: [Rating]
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case genre = "Genre"
        case actors = "Actors"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case director = "Director"
        case writer = "Writer"
        case metascore = "Metascore"
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
        case imdbRating, imdbVotes, imdbID, totalSeasons
    }
}

struct Rating: Codable {
    let source: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}



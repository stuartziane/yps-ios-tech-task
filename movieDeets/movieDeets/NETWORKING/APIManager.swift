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

class APIManager: APIManagerProtocol {
    
    static let apiHost = "www.omdbapi.com"
    
    
    // Search API by imdbID
    
    func searchById(imdbID id: String) -> AnyPublisher<Movie, Error> {
        
        guard let url = buildRequestUrl(queryType: .searchById, with: id) else {
            // We will throw a fatalError for now, but I'll tidy this up later
            fatalError()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Movie.self, decoder: JSONDecoder())
            .subscribe(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    func searchByTitle(movieTitle title: String) -> AnyPublisher<SearchResult, Error> {
        
        guard let url = buildRequestUrl(queryType: .searchByTitle, with: title) else {
            // We will throw a fatalError for now, but I'll tidy this up later
            fatalError()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .subscribe(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    private func buildRequestUrl(queryType query: QueryType, with string: String) -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = APIManager.apiHost
        urlComponents.path = "/"
        
        urlComponents.queryItems = [
            URLQueryItem(name: query.rawValue, value: string),
            URLQueryItem(name: "apikey", value: "b620043c")
        ]
        
        return urlComponents.url
    }
}

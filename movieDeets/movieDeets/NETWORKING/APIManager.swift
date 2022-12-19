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

    
    func searchById(imdbID id: String) -> AnyPublisher<Movie, Error> {
        
        guard let url = buildRequestUrl(queryType: .searchById, with: id, page: nil) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Movie.self, decoder: JSONDecoder())
            .subscribe(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    func searchByTitle(movieTitle title: String, page: Int) -> AnyPublisher<SearchResult, Error> {
        
        guard let url = buildRequestUrl(queryType: .searchByTitle, with: title, page: page) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .subscribe(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    //  This method build the request url from the query parameters
    //  TODO: Put the apikey into keychain (even though it ends up getting url-encoded...)
    
    func buildRequestUrl(queryType query: QueryType, with string: String?, page pageNumber: Int?) -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"       // App Transport Security set to 'allow arbitrary loads'
        urlComponents.host = APIManager.apiHost
        urlComponents.path = "/"
        
        urlComponents.queryItems = [
            URLQueryItem(name: query.rawValue, value: string),
            URLQueryItem(name: "plot", value: "full"),
            URLQueryItem(name: "apikey", value: "b620043c")
        ]
        
        if pageNumber != nil {
            urlComponents.queryItems?.insert(URLQueryItem(name: "Page", value: String(pageNumber!)), at: 2)
        }
        
        return urlComponents.url
    }
}

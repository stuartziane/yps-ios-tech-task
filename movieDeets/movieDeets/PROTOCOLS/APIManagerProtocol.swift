//
//  APIManagerProtocol.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import Foundation
import Combine

protocol APIManagerProtocol {
    
    func searchById(imdbID id: String) -> AnyPublisher<Movie, Error>
    func searchByTitle(movieTitle title: String) -> AnyPublisher<SearchResult, Error>
    
}

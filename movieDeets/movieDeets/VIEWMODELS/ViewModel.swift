//
//  ViewModel.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    @Published var movies = [SearchResultItem]()
    @Published var detailViewMovie: Movie? = .none
    
    @Published var alertShowing: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertBody: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    var apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func fetch(searchTerm: String) {
        
        self.movies.removeAll()
        
        apiManager.searchByTitle(movieTitle: searchTerm)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                    case.finished:
                        break
                    case .failure(let error):
                        self.alertTitle = "An error ocurred!"
                        self.alertBody = "\(error.localizedDescription). Please try again"
                        self.alertShowing = true
                }
            } receiveValue: { searchResult in
                guard let results = searchResult.search else {
                    self.alertTitle = "An error ocurred!"
                    self.alertBody = "Please try again"
                    self.alertShowing = true
                    return
                }
                self.movies = results
            }
            .store(in: &cancellables)
        
    }
    
    func fetch(imdbID: String) {
        
        apiManager.searchById(imdbID: imdbID)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                    case.finished:
                        break
                    case .failure(let error):
                        self.alertTitle = "An error ocurred!"
                        self.alertBody = "\(error.localizedDescription). Please try again"
                        self.alertShowing = true
                }
            } receiveValue: { searchResult in
                self.detailViewMovie = searchResult
            }
            .store(in: &cancellables)
        
    }
    
    // TODO: Implement pagination
    
}

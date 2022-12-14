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
    
    @Published var alertShowing: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertBody: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    private let apiManager = APIManager()
    
    func fetch(searchTerm: String) {
        
        self.movies.removeAll()
        
        apiManager.searchByTitle(movieTitle: searchTerm)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                    case.finished:
                        break
                    case .failure(let error):
                        print(error)
                        self.alertTitle = "An error ocurred!"
                        self.alertBody = "Please try again"
                        self.alertShowing = true
                }
            } receiveValue: { searchResult in
                guard let results = searchResult.results else { return }
                self.movies = results
            }
            .store(in: &cancellables)
        
    }
    
}

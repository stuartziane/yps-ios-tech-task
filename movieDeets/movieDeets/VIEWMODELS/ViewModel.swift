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
                        print("Finished!")
                        break
                    case .failure(let error):
                        print(error)
                        self.alertTitle = "An error ocurred!"
                        self.alertBody = "Please try again"
                        self.alertShowing = true
                }
            } receiveValue: { searchResult in
                guard let results = searchResult.search else {
                    print("There was a problem")
                    return
                }
                print(results)
                self.movies = results
            }
            .store(in: &cancellables)
        
    }
    
}

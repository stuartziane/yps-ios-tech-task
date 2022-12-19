//
//  ViewModel.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import Foundation
import Combine
import Network

class ViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    
    @Published var movies = [SearchResultItem]()
    @Published var detailViewMovie: Movie? = .none
    
    @Published var alertShowing: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertBody: String = ""
    
    @Published var hasNetworkConnectivity: Bool = false
    
    @Published var resultsLoading: Bool = false
    @Published var isLoadingNextPage: Bool = false
    @Published var moreResultsAvailable: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private var numberOfResultsPages = 0
    private var currentPage = 1
    
    private let apiManager: APIManagerProtocol
    
    private let networkMonitor = NWPathMonitor()
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
        
        self.setUpNetworkConnectivityMonitor()
    }
    
    func fetch() {
        
        self.resultsLoading = true
        
        if !isLoadingNextPage {
            self.movies.removeAll()
            self.currentPage = 1
        }
        
        self.isLoadingNextPage = false
        
        apiManager.searchByTitle(movieTitle: searchTerm, page: currentPage)
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
                for movie in results {
                    self.movies.append(movie)
                }
                
                self.calculateNumberOfPagesOfAvailableResults(from: searchResult)
                self.resultsLoading = false
            }
            .store(in: &cancellables)
        
    }
    
    func fetch(imdbID: String) {
        
        self.resultsLoading = true
        
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
                self.resultsLoading = false
            }
            .store(in: &cancellables)
        
    }
    
    func setUpNetworkConnectivityMonitor() {
        
        networkMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                if self.hasNetworkConnectivity == true {
                    return
                } else {
                    DispatchQueue.main.async {
                        self.hasNetworkConnectivity = true
                    }
                }
            } else {
                if self.hasNetworkConnectivity == false {
                    return
                } else {
                    DispatchQueue.main.async {
                        self.hasNetworkConnectivity = false
                        self.alertTitle = "Oops!"
                        self.alertBody = "Your device is currently offline"
                        self.alertShowing = true
                    }
                }
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        networkMonitor.start(queue: queue)
    }
    
    // TODO: Implement pagination
    
    func fetchNextPage() {
        if self.currentPage < self.numberOfResultsPages {
            self.isLoadingNextPage = true
            self.moreResultsAvailable = true
            self.currentPage += 1
            self.fetch()
        } else {
            self.moreResultsAvailable = false
        }
    }
    
    private func calculateNumberOfPagesOfAvailableResults(from searchResult: SearchResult) {
        
        guard let numOfResultsString = searchResult.totalResults else { return }
        guard let numResults = Int(numOfResultsString) else { return }
        
        let pagesAvailable = Int(ceil(Double(numResults) / 10))
        
        if pagesAvailable > 1 {
            self.moreResultsAvailable = true
        }
        
        self.numberOfResultsPages = pagesAvailable
    }
    
}

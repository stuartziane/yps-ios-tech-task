//
//  ContentView.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel
    
    init(apiManager: APIManagerProtocol) {
        _viewModel = StateObject(wrappedValue: ViewModel(apiManager: apiManager))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                SearchBar(viewModel: viewModel)
                    .padding(.horizontal, 20)
                Spacer()
            }

            List {
                ForEach(viewModel.movies, id: \.id) { result in
                    NavigationLink(value: result) {
                        SearchResultRowView(result: result)
                    }
                }
            }
            .listStyle(.plain)
            
            .navigationDestination(for: SearchResultItem.self) { movie in
                MovieDetailView(movie: movie, viewModel: viewModel)
            }
            .alert(viewModel.alertTitle, isPresented: $viewModel.alertShowing) {
                Button("OK", role: .cancel, action: {})
            } message: {
                Text(viewModel.alertBody)
            }
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(apiManager: APIManager())
    }
}

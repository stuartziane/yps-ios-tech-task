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

            List(viewModel.movies, id: \.id) { result in
                Text(result.title)
            }
            .listStyle(.plain)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(apiManager: APIManager())
    }
}

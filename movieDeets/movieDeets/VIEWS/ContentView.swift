//
//  ContentView.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel
    
    init(apiManager: APIManager) {
        _viewModel = StateObject(wrappedValue: ViewModel(apiManager: apiManager))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Text("I'm a search bar!")
                    .padding(.horizontal, 20)
                Spacer()
            }
            
            List {
                ForEach(viewModel.movies, id: \.id) { result in
                    Text(result.title)
                }
            }
            .listStyle(.plain)
            .onAppear {
                viewModel.fetch(searchTerm: "Braveheart")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(apiManager: APIManager())
    }
}

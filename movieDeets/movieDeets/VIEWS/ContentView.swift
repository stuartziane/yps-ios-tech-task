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
                    SearchResultRowView(result: result)
                }
            }
            .listStyle(.plain)
        }
    }
}


struct SearchResultRowView: View {
    
    let result: SearchResultItem
    
    var body: some View {
        HStack {
            
            AsyncImage(url: URL(string: result.poster)) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "popcorn")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
            }
            
            
            VStack (alignment: .leading) {
                Text(result.title)
                    .font(.headline)
                
                Text(result.type)
                Text(result.year)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(apiManager: APIManager())
    }
}

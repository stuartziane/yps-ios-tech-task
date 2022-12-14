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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(viewModel.movies.first?.title ?? "No Title")
        }
        .padding()
        .onAppear {
            self.viewModel.fetch(searchTerm: "Braveheart")
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.alertShowing) {
            Button("OK", role: .cancel, action: {})
        } message: {
            Text(viewModel.alertBody)
        }
        .navigationBarTitleDisplayMode(.automatic)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(apiManager: APIManager())
    }
}

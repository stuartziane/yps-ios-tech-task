//
//  ContentView.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel
    
    @State private var animate = false
    
    @State private var animateLoadingText = false
    
    
    init(apiManager: APIManagerProtocol) {
        _viewModel = StateObject(wrappedValue: ViewModel(apiManager: apiManager))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if !viewModel.hasNetworkConnectivity {
                    Rectangle()
                        .frame(height: 40)
                        .foregroundColor(.red)
                        .opacity(animate ? 1.0 : 0.0)
                        .onAppear {
                            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: true)) {
                                animate.toggle()
                            }
                        }
                        .overlay {
                            Text("Your device is currently offline")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                } else {
                    SearchBar(viewModel: viewModel)
                        .padding(.horizontal, 20)
                }
                Spacer()
            }
            
            .alert(viewModel.alertTitle, isPresented: $viewModel.alertShowing) {
                Button("OK", role: .cancel, action: {})
            } message: {
                Text(viewModel.alertBody)
            }
            .navigationBarTitleDisplayMode(.automatic)

            if !viewModel.movies.isEmpty {
                List {
                    if viewModel.hasNetworkConnectivity {
                        ForEach(viewModel.movies, id: \.id) { result in
                            NavigationLink(value: result) {
                                SearchResultRowView(result: result)
                            }
                        }
                        
                        if viewModel.moreResultsAvailable {
                            HStack {
                                Spacer()
                                VStack {
                                    Text("loading more results")
                                        .opacity(animateLoadingText ? 1.0 : 0.0)
                                        .frame(height: 40)
                                        
                                }
                                .foregroundColor(.blue)
                                Spacer()
                            }
                            .onAppear {
                                withAnimation(Animation.linear(duration: 0.5).repeatForever(autoreverses: true)) {
                                    animateLoadingText.toggle()
                                }
                                viewModel.fetchNextPage()
                            }
                        }
                    } else {
                       EmptyView()
                    }
                    
                }
                .listStyle(.plain)
                
                .navigationDestination(for: SearchResultItem.self) { movie in
                    MovieDetailView(movie: movie, viewModel: viewModel)
                }
            } else {
                VStack {
                    Spacer()
                    
                    Text(viewModel.hasNetworkConnectivity ? "Search for a movie using the search bar above" : "The search bar will appear above when your device is back online")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.light)
                        .opacity(0.7)
                    
                    Spacer()
                }
                .padding(20)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(apiManager: APIManager())
    }
}

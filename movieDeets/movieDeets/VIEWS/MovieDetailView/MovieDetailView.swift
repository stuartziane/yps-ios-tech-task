//
//  MovieDetailView.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import SwiftUI


// TODO: Refactor into sub-views

struct MovieDetailView: View {
    
    let movie: SearchResultItem
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        
        VStack {
            ScrollView {
                
                VStack {
                    if !viewModel.resultsLoading {
                        MovieTitle(viewModel: viewModel)
                        
                        MoviePoster(viewModel: viewModel)
                        
                        Text(viewModel.detailViewMovie?.year ?? "Year Unknown")
                            .fontWeight(.bold)
                        
                        Divider()
                        
                        VStack (alignment: .leading) {
                            Text("Synopsis")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.bottom, 10)
                            
                            Text(viewModel.detailViewMovie?.plot ?? "We don't have information about the plot")
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 30)
                                .font(.italic(.body)())
                            
                            Divider()
                            
                            MovieDetails(viewModel: viewModel)
                        }
                        
                        Divider()
                        
                        if viewModel.detailViewMovie?.ratings != nil {
                            MovieRatings(viewModel: viewModel)
                        } else {
                            
                            VStack {
                                HStack {
                                    Text("Ratings")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 10)
                                    
                                    Spacer()
                                }
                                
                                Text("This movie has no ratings")
                                    .fontWeight(.bold)
                            }
                            .padding(35)
                            
                        }
                    }
                    
                }
                .padding(.horizontal, 35)
            }
        }
        .overlay {
            if viewModel.resultsLoading {
                LoadingView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetch(imdbID: movie.imdbID)
        }
        .onDisappear {
            viewModel.detailViewMovie = nil
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: SearchResultItem(title: "2022", year: "2022", imdbID: "tt2022", type: "movie", poster: "https://m.media-amazon.com/images/M/MV5BMzVlODk0ZDYtMmI0YS00YmYxLWI1ODctYzE3YzkwMmVlZDZiXkEyXkFqcGdeQXVyNjMxNzcwOTI@._V1_SX300.jpg"), viewModel: ViewModel(apiManager: APIManager()))
    }
}

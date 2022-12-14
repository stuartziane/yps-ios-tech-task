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
    
    init(movie: SearchResultItem, viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: ViewModel(apiManager: viewModel.apiManager))
        self.movie = movie
    }
    
    var body: some View {
        
        ScrollView {
            VStack {
                Text(viewModel.detailViewMovie?.title ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(10)
                
                AsyncImage(url: URL(string: movie.poster)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .shadow(radius: 5)
                    
                } placeholder: {
                    Image(systemName: "popcorn")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .foregroundStyle(LinearGradient(colors: [Color.blue, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .overlay {
                            ProgressView()
                        }
                        .shadow(radius: 5)
                }
                
                VStack {
                    Text(viewModel.detailViewMovie?.year ?? "Year Unknown")
                        .fontWeight(.bold)
                }
                
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
                    
                    Group {
                        Text("Details")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        
                        Text("Genre: \(viewModel.detailViewMovie?.genre ?? "Unknown")")
                            .padding(.bottom, 10)
                        
                        Text("Released: \(viewModel.detailViewMovie?.year ?? "Unknown")")
                            .padding(.bottom, 10)
                        
                        Text("Country: \(viewModel.detailViewMovie?.country ?? "Unknown")")
                            .padding(.bottom, 10)
                        
                        Text("Directed by: \(viewModel.detailViewMovie?.director ?? "We don't have information about the director")")
                            .padding(.bottom, 10)
                        
                        Text("Actors: \(viewModel.detailViewMovie?.actors ?? "We don't have information about actors")")
                            .padding(.bottom, 10)
                        
                        Text("Box Office: \(viewModel.detailViewMovie?.boxOffice ?? "We don't have this information")")
                            .padding(.bottom, 10)
                        
                        Text("DVD: \(viewModel.detailViewMovie?.dvd ?? "We don't have this information")")
                            .padding(.bottom, 10)
                        
                        Text("Awards: \(viewModel.detailViewMovie?.awards ?? "We don't any information about awards")")
                            .padding(.bottom, 10)
                    }
                }
                
                Divider()
                
                if viewModel.detailViewMovie?.ratings != nil {
                    VStack {
                        HStack {
                            Text("Ratings")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.bottom, 10)
                            
                            Spacer()
                        }
                        
                        ForEach(viewModel.detailViewMovie!.ratings) { rating in
                            VStack {
                                Text(rating.source)
                                    .fontWeight(.bold)
                                Text(rating.value)
                            }.padding(5)
                        }
                    }
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
            .padding(.horizontal, 35)
            .onAppear {
                viewModel.fetch(imdbID: movie.imdbID)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: SearchResultItem(title: "2022", year: "2022", imdbID: "tt2022", type: "movie", poster: "https://m.media-amazon.com/images/M/MV5BMzVlODk0ZDYtMmI0YS00YmYxLWI1ODctYzE3YzkwMmVlZDZiXkEyXkFqcGdeQXVyNjMxNzcwOTI@._V1_SX300.jpg"), viewModel: ViewModel(apiManager: APIManager()))
    }
}

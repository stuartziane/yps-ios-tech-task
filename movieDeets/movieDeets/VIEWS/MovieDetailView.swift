//
//  MovieDetailView.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: SearchResultItem
    
    @ObservedObject var viewModel: ViewModel
    
    init(movie: SearchResultItem, viewModel: ViewModel) {
        self.movie = movie
        _viewModel = ObservedObject(wrappedValue: ViewModel(apiManager: viewModel.apiManager))
    }
    
    var body: some View {
        Text(viewModel.detailViewMovie?.title ?? "")
            .onAppear {
                print("Appeared")
                viewModel.fetch(imdbID: movie.imdbID)
            }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: SearchResultItem(title: "2022", year: "2022", imdbID: "tt2022", type: "movie", poster: "https://m.media-amazon.com/images/M/MV5BMzVlODk0ZDYtMmI0YS00YmYxLWI1ODctYzE3YzkwMmVlZDZiXkEyXkFqcGdeQXVyNjMxNzcwOTI@._V1_SX300.jpg"), viewModel: ViewModel(apiManager: APIManager()))
    }
}

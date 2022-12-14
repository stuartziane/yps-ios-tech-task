//
//  MovieDetailView.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: SearchResultItem
    let viewModel: ViewModel
    
    var body: some View {
        Text(movie.title)
            .onAppear {
                print("Appeared")
            }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: SearchResultItem(title: "2022", year: "2022", imdbID: "tt2022", type: "movie", poster: "https://m.media-amazon.com/images/M/MV5BMzVlODk0ZDYtMmI0YS00YmYxLWI1ODctYzE3YzkwMmVlZDZiXkEyXkFqcGdeQXVyNjMxNzcwOTI@._V1_SX300.jpg"), viewModel: ViewModel(apiManager: APIManager()))
    }
}

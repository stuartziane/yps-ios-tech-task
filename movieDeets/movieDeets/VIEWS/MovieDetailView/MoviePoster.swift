//
//  MoviePoster.swift
//  movieDeets
//
//  Created by Stuart Ziane on 16/12/2022.
//

import SwiftUI

struct MoviePoster: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var url: String {
        guard let urlString = viewModel.detailViewMovie?.poster! else {
            return ""
        }
        
        return urlString
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .shadow(radius: 5)
            
        } placeholder: {
            ProgressView()
                .padding(100)
        }
    }
}

struct MoviePoster_Previews: PreviewProvider {
    static var previews: some View {
        MoviePoster(viewModel: ViewModel(apiManager: APIManager()))
    }
}

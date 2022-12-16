//
//  MovieRatings.swift
//  movieDeets
//
//  Created by Stuart Ziane on 16/12/2022.
//

import SwiftUI

struct MovieRatings: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
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
    }
}

struct MovieRatings_Previews: PreviewProvider {
    static var previews: some View {
        MovieRatings(viewModel: ViewModel(apiManager: APIManager()))
    }
}

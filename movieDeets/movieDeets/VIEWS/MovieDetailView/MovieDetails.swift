//
//  MovieDetails.swift
//  movieDeets
//
//  Created by Stuart Ziane on 16/12/2022.
//

import SwiftUI

struct MovieDetails: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        
        Text("Details")
            .font(.title)
            .fontWeight(.bold)
            .padding(.bottom, 10)
        
        
        Text("Run time: \(viewModel.detailViewMovie?.runtime ?? "Unknown")")
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

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(viewModel: ViewModel(apiManager: APIManager()))
    }
}

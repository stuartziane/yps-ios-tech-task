//
//  MovieTitle.swift
//  movieDeets
//
//  Created by Stuart Ziane on 16/12/2022.
//

import SwiftUI

struct MovieTitle: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.detailViewMovie?.title ?? "")
            .font(.largeTitle)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .padding(5)
    }
}

struct MovieTitle_Previews: PreviewProvider {
    static var previews: some View {
        MovieTitle(viewModel: ViewModel(apiManager: APIManager()))
    }
}

//
//  SearchResultRowView.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import SwiftUI

struct SearchResultRowView: View {
    
    let result: SearchResultItem
    
    var body: some View {
        HStack (alignment: .top) {
            
            AsyncImage(url: URL(string: result.poster)) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .cornerRadius(10)
            } placeholder: {
                Image(systemName: "popcorn")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
            }
            
            
            VStack (alignment: .leading) {
                Text(result.title)
                    .font(.headline)
                    .padding(.bottom, 5)
                Text(result.year)
                Text(result.type)
            }
            .padding(.leading, 20)
            
            Spacer()
        }
        .padding()
    }
}

struct SearchResultRowView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultRowView(result: SearchResultItem(title: "Braveheart", year: "1995", imdbID: "imdbid", type: "epic movie", poster: "https://preview.redd.it/cejjtc0nwfd41.jpg?auto=webp&s=2d53657c5239e7af1cac1b879314071ad67dbfec"))
    }
}

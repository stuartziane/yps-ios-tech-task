//
//  LoadingView.swift
//  movieDeets
//
//  Created by Stuart Ziane on 16/12/2022.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        VStack {
            ProgressView()
            Spacer()
                .frame(height: 5)
            Text("Loading...")
        }
        .frame(width: 200, height: 200)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

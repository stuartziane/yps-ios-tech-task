//
//  movieDeetsApp.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import SwiftUI

@main
struct movieDeetsApp: App {
    
    @StateObject var viewModel = ViewModel(apiManager: APIManager())
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}

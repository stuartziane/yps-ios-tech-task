//
//  SearchBar.swift
//  movieDeets
//
//  Created by Stuart Ziane on 14/12/2022.
//

import SwiftUI

struct SearchBar: View {
    
    var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    @State private var searchText: String = ""
    
    @State private var isEditing: Bool = false
    
    @FocusState private var searchBarIsFocused: Bool
    
    var body: some View {
        HStack {
            TextField("Search for a movie", text: $searchText)
                .padding(.leading, 30)
                .padding(10)
                .background(Color(uiColor: .systemGray6))
                .foregroundColor(.primary)
                .cornerRadius(10)
                .focused($searchBarIsFocused)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.words)
                .onSubmit {
                    
                    viewModel.fetch(searchTerm: searchText)
                    withAnimation {
                        self.isEditing = false
                    }
                }
                .overlay {
                    HStack {
                        Image(systemName: "magnifyingglass.circle")
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                        if isEditing {
                            Button {
                                self.searchText = ""
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                            }
                            .padding(.trailing, 10)
                            
                            
                        }
                    }
                }
                .onTapGesture {
                    withAnimation {
                        self.isEditing = true
                    }
                }
            
            if isEditing {
                Button {
                    withAnimation {
                        self.isEditing = false
                        self.searchBarIsFocused = false
                    }
                } label: {
                    Text("Cancel")
                }
            }
        }
    }
}


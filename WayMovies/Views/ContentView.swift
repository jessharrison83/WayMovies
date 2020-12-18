//
//  ContentView.swift
//  WayMovies
//
//  Created by Jessica Berler on 11/24/20.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    @ObservedObject var search = SearchMovies()
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "film")
                HStack {
                    TextField("Search Movies, Actors, TV Shows",
                              text: $text,
                              onCommit: { search.loadSearchResults(text) })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: { search.loadSearchResults(text) }) {
                        Image(systemName: "magnifyingglass")
                    }
                }.padding()
                NavigationLink(
                    destination: BrowseMoviesViewController()) {
                    Text("I just want to browse")
                        .foregroundColor(.secondary)
                }
                ZStack {
                    NavigationLink("next page", destination: SearchResultsViewController(loadedResults: search.searchResults), isActive: self.$search.dataIsLoaded)
                }.hidden()
            }

        }.navigationViewStyle(StackNavigationViewStyle())
            .accentColor(.secondary)
    }
}

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
        //Need to figure out how to make background image cover whole screen. None of this is working. Also how to resize the system image.
        NavigationView {
            VStack {
                Image(systemName: "film").foregroundColor(.white).aspectRatio(contentMode: .fill)
                HStack {
                    TextField("Search Movies, Actors, TV Shows",
                              text: $text,
                              onCommit: { search.loadSearchResults(text) })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: { search.loadSearchResults(text) }) {
                        Image(systemName: "magnifyingglass").foregroundColor(.white)
                    }
                }.padding()
                NavigationLink(
                    destination: BrowseMoviesViewController()) {
                    Text("I just want to browse")
                        .foregroundColor(.white)
                }
                ZStack {
                    NavigationLink("next page", destination: SearchResultsViewController(loadedResults: search.searchResults), isActive: self.$search.dataIsLoaded)
                }.hidden()
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(.all)
            .background(Image("default"))

        }.navigationViewStyle(StackNavigationViewStyle())
            .accentColor(.secondary)
        
    }
}

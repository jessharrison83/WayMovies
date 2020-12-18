//
//  SearchBarView.swift
//  WayMovies
//
//  Created by Jessica Berler on 11/30/20.
//

import SwiftUI

struct SearchResultsViewController: View {
    @State var loadedResults = Movies()
    @State var dataIsLoaded: Bool = false
    @State var text: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                VStack {
                    HStack {
                        TextField("Search Movies, Actors, TV Shows",
                                  text: $text,
                                  onCommit: {
                                      loadSearchResults(text)
                                  })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: { loadSearchResults(text) }) {
                            Image(systemName: "magnifyingglass")
                        }
                    }.padding()
                    ForEach(loadedResults.results, id: \.id) {
                        result in
                        SearchResultCard(searchResult: result)
                    }.padding()
                }
            }
        }
    }
    
    
    //this is the same function that is in SearchMovies.swift...need to revisit passing data between views so that I can reuse the function in SearchMovies and not repeat it in other places.
    func loadSearchResults(_ search: String) {
        let config = Config()
        let query = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let searchSession = URLSession.shared
        guard let url = URL(string: "\(config.multiSearchBaseURL)?api_key=\(config.api)&query=\(query ?? search)") else {
            return
        }
        searchSession.dataTask(with: url) {
            data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200 ..< 300).contains(httpResponse.statusCode)
            else {
                return
            }
            guard let data = data else {
                fatalError()
            }
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(Movies.self, from: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self.loadedResults = response
                self.dataIsLoaded = true
            }
        }.resume()
    }
}

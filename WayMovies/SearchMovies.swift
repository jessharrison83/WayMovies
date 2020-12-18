//
//  SearchBarView.swift
//  WayMovies
//
//  Created by Jessica Berler on 12/15/20.
//

import SwiftUI

class SearchMovies: ObservableObject {
    @Published var dataIsLoaded: Bool = false
    @Published var searchResults = Movies()
    @Published var query: String = ""
    private var config = Config()

    init() {
        return
    }

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
                print(response)
                self.searchResults = response
                self.dataIsLoaded = true
                print(self.dataIsLoaded)
            }
        }.resume()
    }
}

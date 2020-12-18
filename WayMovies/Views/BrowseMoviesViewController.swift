//
//  HorizontalScrollView.swift
//  WayMovies
//
//  Created by Jessica Berler on 11/30/20.
//

import Combine
import Foundation
import SwiftUI

struct BrowseMoviesViewController: View {
    @ObservedObject var movies = BrowseMovies()
    @State var search: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            if movies.dataIsLoaded {
                Text("Upcoming Movies")
                ScrollView(.horizontal) {
                    HStack(spacing: 30) {
                        ForEach(movies.upcomingMovies.results, id: \.id) {
                            movie in
                            BrowseCard(movie: movie)
                        }
                    }
                    .padding()
                }
                Text("Top Rated Movies")
                ScrollView(.horizontal) {
                    HStack(spacing: 30) {
                        ForEach(movies.topRatedMovies.results, id: \.id) {
                            movie in
                            BrowseCard(movie: movie)
                        }
                    }
                    .padding()
                }
                Text("Now Playing")
                ScrollView(.horizontal) {
                    HStack(spacing: 30) {
                        ForEach(movies.nowPlayingMovies.results, id: \.id) {
                            movie in
                            BrowseCard(movie: movie)
                        }
                    }
                    .padding()
                }
            } else {
                Text("Loading...")
            }
        }.padding()
    }
}

class BrowseMovies: ObservableObject {
    @Published var dataIsLoaded: Bool = false
    @Published var upcomingMovies = Movies()
    @Published var topRatedMovies = Movies()
    @Published var nowPlayingMovies = Movies()
    private var config = Config()

    init() {
        loadBrowseMovies()
    }

    func loadBrowseMovies() {
        let categories = ["upcoming", "top_rated", "now_playing"]
        let movieSession = URLSession.shared
        for category in categories {
            guard let url = URL(string: "\(config.movieBaseURL)/\(category)?api_key=\(config.api)") else {
                return
            }
            movieSession.dataTask(with: url) {
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
                    switch category {
                    case Categories.upcoming.rawValue:
                        self.upcomingMovies = response
                    case Categories.topRated.rawValue:
                        self.topRatedMovies = response
                    case Categories.nowPlaying.rawValue:
                        self.nowPlayingMovies = response
                    default:
                        return
                    }
                    self.dataIsLoaded = true
                }
            }.resume()
        }
    }
}

//
//  MovieCard.swift
//  WayMovies
//
//  Created by Jessica Berler on 11/30/20.
//

import Foundation

class Movie: Codable {
    var id: Int
    var overview: String?
    var poster_path: String?
    var title: String?
    var vote_average: Double?
    var vote_count: Int?
    var media_type: String?
    var name: String?
    var profile_path: String?

    init(id: Int = 780, overview: String = "Overview", poster_path: String = "default", title: String = "Movie Title", vote_average: Double = 7.89, vote_count: Int = 5000, media_type: String = "tv", name: String = "some actor", profile_path _: String = "default") {
        self.id = id
        self.overview = overview
        self.poster_path = poster_path
        self.title = title
        self.vote_average = vote_average
        self.vote_count = vote_count
        self.media_type = media_type
        self.name = name
    }
}

struct Movies: Codable {
    var results: [Movie]

    init(results: [Movie] = [Movie()]) {
        self.results = results
    }
}

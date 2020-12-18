//
//  Config.swift
//  WayMovies
//
//  Created by Jessica Berler on 12/8/20.
//
import Foundation

struct Config {
    let imageBaseURL: String = "https://image.tmdb.org/t/p"
    let movieBaseURL: String = "https://api.themoviedb.org/3/movie"
    let multiSearchBaseURL: String = "https://api.themoviedb.org/3/search/multi"
    //how do I store api keys safely in iOS? 
    let api: String = "71ab1b19293efe581c569c1c79d0f004"
}

enum Categories: String {
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
    case upcoming
}

enum MediaType: String {
    case movie
    case tvShow = "tv"
    case person
}

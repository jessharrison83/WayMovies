//
//  Movie Views.swift
//  WayMovies
//
//  Created by Jessica Berler on 11/30/20.
//

import SwiftUI

struct CardImage: View {
    @State var imagesAreLoaded: Bool = false
    @State var movieImage: Image? = Image("default")
    var movieImagePath: String?
    var config = Config()
    var body: some View {
        if imagesAreLoaded {
            self.movieImage!
                .resizable()
                .cornerRadius(5.0)
        } else {
            VStack {
                Text("Loading...")
            }.onAppear(perform: getImage)
        }
    }
    //this is still incredibly slow for browse. Go back through concurrency/GCD videos and see what else might work. Right now, browse view sends calls to three category endpoints, goes through the results with a ForEach and puts them in a BrowseCard, which then does another call for each of them to get the image data. The category endpoint calls are fast, just images take forever to load.
    func getImage() {
        if movieImagePath != nil {
            var imageData: UIImage?
            guard let imageURL = URL(string: "\(config.imageBaseURL)/original\(movieImagePath!)") else {
                return
            }
            URLSession.shared.dataTask(with: imageURL) { data, _, error in
                guard error == nil else {
                    print(error!)
                    return
                }
                if data != nil {
                    DispatchQueue.main.async {
                        imageData = UIImage(data: data!)
                        if imageData != nil {
                            self.movieImage = Image(uiImage: imageData!)
                        } else {
                            return
                        }
                        self.imagesAreLoaded = true
                    }
                } else {
                    return
                }
            }.resume()
        } else {
            movieImage = Image("default")
            imagesAreLoaded = true
            return
        }
    }
}

struct BrowseCard: View {
    let movie: Movie
    var body: some View {
        NavigationLink(destination: ResultDetailViewController(movie: movie)) {
            VStack {
                CardImage(movieImagePath: (movie.poster_path ?? movie.profile_path) ?? nil)
                Text((movie.title ?? movie.name) ?? "fix this for an actor")
                    .lineLimit(1)
                if movie.vote_average != nil {
                    StarRatingViewController(rating: movie.vote_average!)
                }
            }
            .frame(minWidth: 120, maxWidth: 160, minHeight: 120, maxHeight: 200)
        }.foregroundColor(.black)
    }
}

struct SearchResultCard: View {
    var searchResult: Movie
    var body: some View {
        NavigationLink(destination: ResultDetailViewController(movie: searchResult)) {
            VStack {
                Text(searchResult.media_type ?? "Unspecified")
                    .fontWeight(.semibold)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(3)
                    .background(Color.pink)
                Text((searchResult.title ?? searchResult.name) ?? "unknown")
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                if searchResult.vote_average != nil {
                    StarRatingViewController(rating: searchResult.vote_average!)
                }
            }
            .padding(30)
            .background(CardImage(movieImagePath: searchResult.poster_path ?? nil))
            .frame(minWidth: 120, maxWidth: 200, minHeight: 100, maxHeight: 180)
        }
    }
}

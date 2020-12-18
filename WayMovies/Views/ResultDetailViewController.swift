//
//  DetailView.swift
//  WayMovies
//
//  Created by Jessica Berler on 11/30/20.
//

import SwiftUI

struct ResultDetailViewController: View {
    let movie: Movie
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(movie.media_type ?? "Movie")
                    .fontWeight(.semibold)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(3)
                    .background(Color.pink)
                Text(movie.title ?? movie.name ?? "fix this")
                    .foregroundColor(.white)
                    .padding(.bottom, 2)
                if movie.vote_average != nil {
                    StarRatingViewController(rating: movie.vote_average!)
                }
            }
        }.padding(.bottom)
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .bottomLeading
            )
            .background(CardImage(movieImagePath: movie.poster_path ?? nil).edgesIgnoringSafeArea(.all))

        VStack(alignment: .leading) {
            Text("Overview")
                .fontWeight(.bold)
                .padding(.bottom)
            Text(movie.overview ?? "no overview provided")

        }.padding(.top, 25)
    }
}

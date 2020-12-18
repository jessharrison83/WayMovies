//
//  StarRatingView.swift
//  WayMovies
//
//  Created by Jessica Berler on 11/30/20.
//

import SwiftUI

struct StarRatingViewController: View {
    var rating: Double
    func convertToStars(_ rating: Double) -> Int {
        let convertedRating = Int(rating / 2)
        let stars: Int
        if convertedRating >= 1 {
            stars = convertedRating
        } else {
            stars = 1
        }
        return stars
    }

    var max: Int = 5
    var body: some View {
        HStack {
            ForEach(1 ..< (max + 1), id: \.self) {
                i in
                if i <= convertToStars(rating) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "star")
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingViewController(rating: 9)
    }
}

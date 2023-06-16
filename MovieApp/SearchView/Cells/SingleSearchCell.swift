//
//  SingleSearchCell.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 11/2/22.
//

import Foundation
import UIKit

class SingleSearchCell: UICollectionViewCell {
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieName: UILabel!
    @IBOutlet var movieRating: UILabel!
    @IBOutlet var moviePopularity: UILabel!
    @IBOutlet var movieReleaseYear: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(movie: FeedMovie) {
        let movieImageUrl = "https://image.tmdb.org/t/p/w200" + (movie.poster_path ?? "")
        movieImage.kf.setImage(with: URL(string: movieImageUrl), placeholder: UIImage(named: "skode"))
        movieName.text = movie.title
        movieRating.text = "\(String(describing: movie.vote_average ?? 0.0))/10"
        movieReleaseYear.text = String(movie.release_date?.prefix(4) ?? "")
        moviePopularity.text = "\(String(describing: movie.popularity ?? 0))"
    }
}

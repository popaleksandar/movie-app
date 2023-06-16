//
//  SingleCategorisedMovie.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 9/26/22.
//

import Foundation
import Kingfisher
import UIKit

class SingleCategorisedMovie: UICollectionViewCell {
    @IBOutlet var movieImage: UIImageView!
    
    func configure(imagePath: String) {
        let imageURL = "https://image.tmdb.org/t/p/w200" + imagePath
        movieImage.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "skode"))
        movieImage.layer.cornerRadius = 16
    }
}

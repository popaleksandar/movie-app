//
//  ReviewsCell.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 11/1/22.
//

import Foundation
import UIKit


class ReviewsCell: UICollectionViewCell {
    @IBOutlet var username: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var rank: UILabel!
    @IBOutlet var comment: UILabel!
    
    func configure(review: SingleMovieReview?) {
        if let review = review {
            username.text = review.author_details?.username ?? "No Name"
            rank.text = "\(review.author_details?.rating ?? 0)"
            comment.text = review.content
            
            let imageURL = "https://image.tmdb.org/t/p/w200" + (review.author_details?.avatar_path ?? "")
            userImage.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "skode"))
        }
    }
}

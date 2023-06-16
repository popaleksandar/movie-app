//
//  RankListCell.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 9/26/22.
//

import Foundation
import UIKit

class SingleMovieCell: UICollectionViewCell {
    @IBOutlet var rank: UILabel!
    @IBOutlet var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(rank: Int, imagePath: String) {
        let imageURL = "https://image.tmdb.org/t/p/w200" + imagePath
        image.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "skode"))
        image.layer.cornerRadius = 16
        self.rank.text = "\(rank)"
        
        self.rank.attributedText = NSMutableAttributedString(string: "\(rank)", attributes: [
            NSAttributedString.Key.strokeColor: UIColor(red: 0.01, green: 0.59, blue: 0.90, alpha: 1.00),
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.14, green: 0.16, blue: 0.20, alpha: 1.00),
            NSAttributedString.Key.strokeWidth: 0.5,
            NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 96)!
        ])
    }

}

//
//  SingleCategory.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 9/26/22.
//

import Foundation
import UIKit

class SingleCategory: UICollectionViewCell {
    @IBOutlet var movieCategory: UILabel!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(category: String) {
        movieCategory.text = category
    }
}

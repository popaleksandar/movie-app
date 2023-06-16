//
//  AvailableOnCell.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 11/4/22.
//

import Foundation
import UIKit

class CastAndCrewCell: UICollectionViewCell {
    @IBOutlet var castName: UILabel!
    @IBOutlet weak var castCharacter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }

    func configure(cast: Cast?) {
        if let cast = cast {
            self.castName.text = cast.name
            self.castCharacter.text = cast.character
        }
    }
}

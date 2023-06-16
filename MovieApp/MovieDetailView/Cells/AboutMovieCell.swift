//
//  AboutMovieCell.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 11/1/22.
//

import Foundation
import UIKit

class AboutMovieCell: UICollectionViewCell {
    
    @IBOutlet var desc: UILabel!
    
    
    func configure(desc: String?) {
        if let desc = desc{
            self.desc.text = desc
        } else {
            self.desc.text = "No Description"
        }
        
    }
}

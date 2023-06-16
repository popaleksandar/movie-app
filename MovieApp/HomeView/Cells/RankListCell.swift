//
//  RankListCell.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 9/27/22.
//

import Foundation
import UIKit

protocol RankListDelegate: AnyObject {
    func didSelectMovie(movieId: Int?)
}

class RankListCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var rankListCollectionView: UICollectionView!
    
    
    weak var delegate: RankListDelegate?
    
    static var reuseIdentifier = "RankListCell"
    static var height: CGFloat = 20
    
    var dataSource: [FeedMovie] = []
    
    func reloadDataSource() {
        rankListCollectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rankListCollectionView.delegate = self
        rankListCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        layout.sectionInset = .init(top: 0, left: 35, bottom: 0, right: 24)
        layout.itemSize = CGSize(width: 145, height: 220)
        rankListCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = rankListCollectionView.dequeueReusableCell(withReuseIdentifier: "SingleMovieCell", for: indexPath) as! SingleMovieCell
        cell.configure(rank: indexPath.row + 1, imagePath: dataSource[indexPath.row].poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectMovie(movieId: dataSource[indexPath.item].id)
    }
}

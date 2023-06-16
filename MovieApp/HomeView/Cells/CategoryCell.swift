//
//  CategoryCell.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 9/27/22.
//

import Foundation
import UIKit

protocol CategoryDelegate: AnyObject {
    func didSelectCategory(category: MovieService.categoryType)
}


class CategoryCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var categoryCollectionView: UICollectionView!
    
    weak var delegate: CategoryDelegate?
    
    var dataSource: [MovieService.categoryType] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = .init(top: 0, left: 24, bottom: 0, right: 8)
        layout.itemSize = CGSize(width: 100, height: 45)
        categoryCollectionView.collectionViewLayout = layout
    }
    
    func reloadDataSource() {
        categoryCollectionView.reloadData()
    }
        
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "SingleCategory", for: indexPath) as! SingleCategory
        cell.configure(category: self.dataSource[indexPath.row].title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.categoryCollectionView.reloadSections(IndexSet(integer: 0))
        delegate?.didSelectCategory(category: dataSource[indexPath.item])
    }
}

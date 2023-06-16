//
//  LudiViewController.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 9/29/22.
//

import Foundation
import UIKit

class LudiViewController: UIViewController {
    @IBOutlet var ludCollectionView: UICollectionView!
    
    let viewModel = LudiViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getRankListMovies()
        viewModel.getCategorisedMovies(categoryType: .nowPlayingMovies)
        ludCollectionView.delegate = self
        ludCollectionView.dataSource = self
        ludCollectionView.collectionViewLayout = createLayout()
        bindUI()
    }
    
    func bindUI() {
        print("pre")
        viewModel.categoriesMoviesDataSourceArrived = { [weak self] in
            self?.ludCollectionView.reloadData()
            
        }
        print("posle")
    }
    
    deinit {
        print("deiniciro se ludi vju kontoler deiniciro se")
    }
}

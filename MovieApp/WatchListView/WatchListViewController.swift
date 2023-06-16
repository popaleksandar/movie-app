//
//  WatchListViewController.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/8/22.
//

import Foundation
import UIKit

class WatchListViewController: UIViewController {
    let viewModel = WatchListViewModel()

    @IBOutlet var wathcListCollectionView: UICollectionView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getWatchList(completion: { (succeeded: Bool, _: Error?) in
            if succeeded == true {
                self.wathcListCollectionView.dataSource = self
                self.wathcListCollectionView.delegate = self
                self.wathcListCollectionView.collectionViewLayout = self.createLayout()
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

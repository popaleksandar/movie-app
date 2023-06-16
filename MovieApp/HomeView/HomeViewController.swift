//
//  ViewController.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 9/26/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var homeCollectionView: UICollectionView!

    let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        viewModel.getRankListMovies()
        viewModel.getCategorisedMovies(categoryType: .nowPlayingMovies)
        bindUI()
    }

    func bindUI() {
        print("pre")
        viewModel.categoriesMoviesDataSourceArrived = { [weak self] in
            self?.homeCollectionView.reloadData()
        }
        print("posle")
    }
}

extension HomeViewController: CategoryDelegate {
    func didSelectCategory(category: MovieService.categoryType) {
        print(category)
        viewModel.getCategorisedMovies(categoryType: category)
    }
}

extension HomeViewController: RankListDelegate {
    func didSelectMovie(movieId: Int?) {
        if let movieId = movieId {
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
            vc?.viewModel.movieId = movieId
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
}

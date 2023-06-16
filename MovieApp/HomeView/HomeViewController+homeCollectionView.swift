//
//  HomeViewController+homeCollectionView.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 9/26/22.
//

import Foundation
import UIKit

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource[section].row.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.dataSource[indexPath.section].row[indexPath.item] {
        case .rankListCell(let movies):
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "RankListCell", for: indexPath) as! RankListCell
            cell.dataSource = movies
            cell.reloadDataSource()
            cell.delegate = self
            return cell
        case .categoryTypesCell(let titles):
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.dataSource = titles
            cell.reloadDataSource()
            cell.delegate = self
            return cell
        case .categorisedMovieCell(let movie):
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "SingleCategorisedMovie", for: indexPath) as! SingleCategorisedMovie
            cell.configure(imagePath: movie.poster_path ?? "")
            return cell
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.dataSource[indexPath.section].section {
        case .rankList:
            print("RANK LIST")
            return CGSize(width: collectionView.frame.size.width, height: 220)
        case .categoryTypes:
            print("category LIST")
            return CGSize(width: collectionView.frame.size.width, height: 45)
        case .categorisedMovies:
            print("categorized LIST")
            print((collectionView.frame.size.width / 3).rounded() - 40)
            return CGSize(width: (collectionView.frame.size.width / 3).rounded() - 40, height: 145)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch viewModel.dataSource[section].section {
        case .categorisedMovies:
            return 20
        default:
            return 0.0
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch viewModel.dataSource[section].section {
        case .categorisedMovies:
            return 20
        default:
            return 0.0
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch viewModel.dataSource[section].section {
        case .categorisedMovies:
            return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.dataSource[indexPath.section].row[indexPath.item] {
        case .categorisedMovieCell(let movie):
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
            vc?.viewModel.movieId = movie.id
            self.navigationController?.pushViewController(vc!, animated: true)
        default:
            return
        }
    }
}

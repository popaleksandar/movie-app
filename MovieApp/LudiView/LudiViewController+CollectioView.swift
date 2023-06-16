//
//  LudiViewController+CollectioView.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/6/22.
//

import Foundation
import UIKit

extension LudiViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource[section].rows.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.dataSource[indexPath.section].rows[indexPath.row] {
        case .rankListCell(let movie):
            let cell = ludCollectionView.dequeueReusableCell(withReuseIdentifier: "SingleMovieCell", for: indexPath) as! SingleMovieCell
            cell.configure(rank: indexPath.row + 1, imagePath: movie.poster_path ?? "")
            return cell
        case .categoryTypesCell(let category):
            let cell = ludCollectionView.dequeueReusableCell(withReuseIdentifier: "SingleCategory", for: indexPath) as! SingleCategory
            cell.configure(category: category.title)
            return cell
        case .categorisedMovieCell(let movie):
            let cell = ludCollectionView.dequeueReusableCell(withReuseIdentifier: "SingleCategorisedMovie", for: indexPath) as! SingleCategorisedMovie
            cell.configure(imagePath: movie.poster_path ?? "")
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.dataSource[indexPath.section].rows[indexPath.row] {
        case .categorisedMovieCell(let movie), .rankListCell(let movie):
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
            vc?.viewModel.movieId = movie.id
            self.navigationController?.pushViewController(vc!, animated: true)
        case .categoryTypesCell(let category):
            viewModel.getCategorisedMovies(categoryType: category)
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] section, _ in
            switch section {
            case 0:
                return self?.createRankSection()
            case 1:
                return self?.createCategorySection()
            default:
                return self?.createCategorisedMoviesSection()
            }
        }
    }
    
    func createRankSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(220)
            ),
            subitem: item,
            count: 2
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    func createCategorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.33),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(20)
            ),
            subitem: item,
            count: 3
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 0)
        
        return section
    }
    
    func createCategorisedMoviesSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.33),
                heightDimension: .absolute(145)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(145)
            ),
            subitems: [item]
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24)
        section.interGroupSpacing = 10
        
        return section
    }
}

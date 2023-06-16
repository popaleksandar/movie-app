//
//  MovieDetailViewController+CollectionView.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/8/22.

import Foundation
import UIKit

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.moviewReviews?.results.count ?? 0
        default:
            return viewModel.movieCastAndCrew?.count ?? 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        changeSectionButtonColor(section: indexPath.section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = moviewDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "AboutMovieCell", for: indexPath) as! AboutMovieCell
//            changeSectionButtonColor(section: indexPath.section)
            cell.configure(desc: viewModel.movieDetails?.overview)
            return cell
        case 1:
            let cell = moviewDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "ReviewsCell", for: indexPath) as! ReviewsCell
            cell.configure(review: viewModel.moviewReviews?.results[indexPath.item])
            return cell
        default:
            let cell = moviewDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "CastAndCrewCell", for: indexPath) as!
            CastAndCrewCell
            cell.configure(cast: viewModel.movieCastAndCrew?[indexPath.item])
            return cell
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfiguration.scrollDirection = .horizontal
        
    
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] section, _ in
            switch section {
            case 0:
                return self?.createAboutMovieSection()
            case 1:
                return self?.createReviewsSectionLayout()
            default:
                return self?.createCastSectionLayout()
            }
        }, configuration: layoutConfiguration)
    }

    //
    func createAboutMovieSection() -> NSCollectionLayoutSection {
        // ABOUT MOVIE ITEM
        let aboutMovieItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(128)
            )
        )
        aboutMovieItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        // ABOUT MOVIE GROUP
        let aboutMovieGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(128)
            ),
            subitem: aboutMovieItem,
            count: 1
        )
        aboutMovieGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30)
        
        let section = NSCollectionLayoutSection(group: aboutMovieGroup)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    func createReviewsSectionLayout() -> NSCollectionLayoutSection {
        // REVIEWS ITEM
        let reviewsItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(120)
            )
        )
        reviewsItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 29, bottom: 5, trailing: 29)
        // REVIEWS GROUP
        let reviewsGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(120)
            ),
            subitems: [reviewsItem]
        )
        reviewsGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: reviewsGroup)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 24
        
        return section
    }
    
    func createCastSectionLayout() -> NSCollectionLayoutSection {
        // CAST ITEM
        let castItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(120)
            )
        )
        castItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 29, bottom: 5, trailing: 29)
        // CAST GROUP
        let castGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(120)
            ),
            subitems: [castItem]
        )
        castGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: castGroup)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    
    //seljana
    func changeSectionButtonColor(section: Int) {
        switch section {
        case 0:
            aboutMovieButton.setTitleColor(UIColor(named: "defaultGrey"), for: .normal)
            aboutMovieButton.backgroundColor = .white
            
            reviwsButton.setTitleColor(.white, for: .normal)
            reviwsButton.backgroundColor = UIColor(named: "defaultGrey")
            
            castButton.setTitleColor(.white, for: .normal)
            castButton.backgroundColor = UIColor(named: "defaultGrey")
        case 1:
            aboutMovieButton.setTitleColor(.white, for: .normal)
            aboutMovieButton.backgroundColor = UIColor(named: "defaultGrey")
    
            reviwsButton.setTitleColor(UIColor(named: "defaultGrey"), for: .normal)
            reviwsButton.backgroundColor = .white
            
            castButton.setTitleColor(.white, for: .normal)
            castButton.backgroundColor = UIColor(named: "defaultGrey")
        default:
            aboutMovieButton.setTitleColor(.white, for: .normal)
            aboutMovieButton.backgroundColor = UIColor(named: "defaultGrey")
            
            reviwsButton.setTitleColor(.white, for: .normal)
            reviwsButton.backgroundColor = UIColor(named: "defaultGrey")
            
            castButton.setTitleColor(UIColor(named: "defaultGrey"), for: .normal)
            castButton.backgroundColor = .white
        }
    }
}

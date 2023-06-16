//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/8/22.
//

import CoreData
import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    let viewModel = MovieDetailViewModel()
    
    @IBOutlet var moviewDetailsCollectionView: UICollectionView!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var smallerImage: UIImageView!
    @IBOutlet var movieName: UILabel!
    @IBOutlet var genre: UILabel!
    @IBOutlet var movieRank: UILabel!
    @IBOutlet var length: UILabel!
    @IBOutlet var releaseYear: UILabel!
    
    @IBOutlet var aboutMovieButton: UIButton!
    @IBAction func aboutMovieButtonAction(_ sender: Any) {
        moviewDetailsCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
    
    @IBOutlet var reviwsButton: UIButton!
    @IBAction func reviewsButton(_ sender: Any) {
        moviewDetailsCollectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .left, animated: true)
    }
    
    @IBOutlet var castButton: UIButton!
    @IBAction func castButtonAction(_ sender: Any) {
        moviewDetailsCollectionView.scrollToItem(at: IndexPath(row: 0, section: 2), at: .left, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getMovieDetails(completion: { (succeeded: Bool, problem: Error?) in
            if succeeded == true {
                self.setupUI()
                self.moviewDetailsCollectionView.reloadSections(IndexSet(integer: 0))
            } else {
                let alert = UIAlertController(title: "Error", message: problem?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
        viewModel.getMovieReviews(completion: { (succeeded: Bool, problem: Error?) in
            if succeeded == true {
                self.moviewDetailsCollectionView.reloadSections(IndexSet(integer: 1))
            } else {
                self.moviewDetailsCollectionView.reloadSections(IndexSet(integer: 1))
                let alert = UIAlertController(title: "Error", message: problem?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
        
        viewModel.getCastAndCrew(completion: { (succeeded: Bool, _: Error?) in
            if succeeded == true {
                self.moviewDetailsCollectionView.reloadSections(IndexSet(integer: 2))
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
     
        moviewDetailsCollectionView.delegate = self
        moviewDetailsCollectionView.dataSource = self
        moviewDetailsCollectionView.collectionViewLayout = createLayout()
        moviewDetailsCollectionView.alwaysBounceVertical = false
        moviewDetailsCollectionView.isPagingEnabled = false
        moviewDetailsCollectionView.isScrollEnabled = false
    }
    
    func setupUI() {
        setupWatchListButton(add: viewModel.isEntityAttributeExist(id: viewModel.movieId))
        movieName.text = viewModel.movieDetails?.title
        let backImageUrl = "https://image.tmdb.org/t/p/w500" + (viewModel.movieDetails?.backdrop_path ?? "")
        let posterImageUrl = "https://image.tmdb.org/t/p/w200" + (viewModel.movieDetails?.poster_path ?? "")
        movieRank.text = "\(viewModel.movieDetails?.vote_average ?? 0)/10"
        posterImage.kf.setImage(with: URL(string: backImageUrl), placeholder: UIImage(named: "skode"))
        smallerImage.kf.setImage(with: URL(string: posterImageUrl), placeholder: UIImage(named: "skode"))
        if let year = viewModel.movieDetails?.release_date {
            releaseYear.text = String(year.prefix(4))
        }
        genre.text = viewModel.movieDetails?.genres.first?.name
        length.text = "\(viewModel.movieDetails?.runtime ?? 0) Min"
    }
    
    @objc func addToWatchList() {
        setupWatchListButton(add: true)
        viewModel.addToWatchList(completion: { (succeeded: Bool, problem: Error?) in
            if succeeded == false {
                let alert = UIAlertController(title: "Error", message: problem?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.setupWatchListButton(add: false)
            }
        })
    }
    
    @objc func removeFromWatchList() {
        setupWatchListButton(add: false)
        viewModel.removeFromWatchList(completion: { (succeeded: Bool, problem: Error?) in
            if succeeded == false {
                let alert = UIAlertController(title: "Error", message: problem?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.setupWatchListButton(add: true)
            }
        })
    }
    
    func setupWatchListButton(add: Bool) {
        if add {
            let watchListButton = UIBarButtonItem(image: UIImage(named: "InWatchList"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(removeFromWatchList))
            navigationItem.rightBarButtonItem = watchListButton
        } else {
            let watchListButton = UIBarButtonItem(image: UIImage(named: "NotInWatchList"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(addToWatchList))
            navigationItem.rightBarButtonItem = watchListButton
        }
    }
}

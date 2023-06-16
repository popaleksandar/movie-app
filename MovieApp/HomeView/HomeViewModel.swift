//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/19/22.
//

import Foundation

class HomeViewModel {

    let movieService = MovieService()
    var dataSource: [HomeViewSectionData] = [
        (HomeViewSection.rankList, [HomeViewRows.rankListCell(movies: [])]),
        (HomeViewSection.categoryTypes, [HomeViewRows.categoryTypesCell(titles: [.upcomingMovies, .popularMovies, .nowPlayingMovies, .topRatedMovies])]),
        (HomeViewSection.categorisedMovies, [])
    ]

    var categoriesMoviesDataSourceArrived: (() -> ())?
    
    func getRankListMovies() {
        movieService.getMovies(categoryType: .topRatedMovies, completion: { [weak self] result in
            switch result {
            case .success(let movies):
                self?.dataSource[0].row = [HomeViewRows.rankListCell(movies: movies.results)]
                self?.categoriesMoviesDataSourceArrived?()
            case .failure(let error):
                print(error)
            }
        })
    }

    func getCategorisedMovies(categoryType: MovieService.categoryType) {
        movieService.getMovies(categoryType: categoryType, completion: { [weak self] result in
            switch result {
            case .success(let movies):
                var rows: [HomeViewRows] = []
                for movie in movies.results {
                    let m = HomeViewRows.categorisedMovieCell(movie: movie)
                    rows.append(m)
                }
                let section = (HomeViewSection.categorisedMovies, rows)
                self?.dataSource[2] = section
                self?.categoriesMoviesDataSourceArrived?()
            case .failure(let error):
                print(error)
            }
        })
    }
}

enum HomeViewSection: Int {
    case rankList
    case categoryTypes
    case categorisedMovies
}

enum HomeViewRows {
    case rankListCell(movies: [FeedMovie])
    case categoryTypesCell(titles: [MovieService.categoryType])
    case categorisedMovieCell(movie: FeedMovie)
}


typealias HomeViewSectionData = (section: HomeViewSection, row: [HomeViewRows])

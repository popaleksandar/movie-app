//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/12/22.
//

import Foundation

class LudiViewModel {
    enum movieDataSource {
        case nowPlayingMovies
        case popularMovies
        case topRatedMovies
    }

    let movieService = MovieService()
    var dataSource: [LudiViewDataModel] = [(.rankList, []), (.categoryTypes, []), (.categorisedMovies, [])]

    var categoriesMoviesDataSourceArrived: (() -> ())?
    
    init() {
        let secondSection: LudiViewDataModel = (.categoryTypes, [
            .categoryTypesCell(category: .upcomingMovies),
            .categoryTypesCell(category: .popularMovies),
            .categoryTypesCell(category: .nowPlayingMovies),
            .categoryTypesCell(category: .topRatedMovies)
        ])
        dataSource[LudiViewSection.categoryTypes.rawValue].rows = secondSection.rows
    }

    func getRankListMovies() {
        movieService.getMovies(categoryType: .topRatedMovies, completion: { [weak self] result in
            switch result {
            case .success(let movies):
                let movieCells = movies.results.compactMap { movie in
                    LudiViewRows.rankListCell(movie: movie)
                }

                self?.dataSource[LudiViewSection.rankList.rawValue].rows = movieCells
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
                let movieCells = movies.results.compactMap { movie in
                    LudiViewRows.categorisedMovieCell(movie: movie)
                }

                let section: LudiViewDataModel = (.categorisedMovies, movieCells)
                self?.dataSource[LudiViewSection.categorisedMovies.rawValue] = section
                self?.categoriesMoviesDataSourceArrived?()
            case .failure(let error):
                print(error)
            }
        })
    }
}

enum LudiViewSection: Int {
    case rankList, categoryTypes, categorisedMovies
}

enum LudiViewRows {
     case rankListCell(movie: FeedMovie)
    case categoryTypesCell(category: MovieService.categoryType)
    case categorisedMovieCell(movie: FeedMovie)
}

typealias LudiViewDataModel = (section: LudiViewSection, rows: [LudiViewRows])

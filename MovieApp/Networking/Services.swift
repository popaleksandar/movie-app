//
//  Services.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/12/22.
//

import Alamofire
import Foundation

class MovieService {
    enum categoryType {
        case nowPlayingMovies
        case popularMovies
        case topRatedMovies
        case latestMovies
        case upcomingMovies
        
        var title: String {
            switch self {
            case .nowPlayingMovies:
                return "Now Playing"
            case .popularMovies:
                return "Popular"
            case .latestMovies:
                return "Latest"
            case .upcomingMovies:
                return "Upcoming"
            case .topRatedMovies:
                return "Top Rated"
            }
        }
    }

    let apiManager = APIManager()

    func getMovies(categoryType: categoryType, completion: @escaping ApiResponseGeneric<TrendingMovie>) {
        switch categoryType {
        case .nowPlayingMovies:
            apiManager.sendRequest(type: Router.getNowPlayingMovies, handler: completion)
        case .popularMovies:
            apiManager.sendRequest(type: Router.getPopularMovies, handler: completion)
        case .topRatedMovies:
            apiManager.sendRequest(type: Router.getTopRatedMovies, handler: completion)
        case .latestMovies:
            apiManager.sendRequest(type: Router.getLatestMovies, handler: completion)
        case .upcomingMovies:
            apiManager.sendRequest(type: Router.getUpcomingMovies, handler: completion)
        }
    }
}

class AuthService {
    let apiManager = APIManager()

    func getRequestToken(completion: @escaping ApiResponseGeneric<LoginData>) {
        apiManager.sendRequest(type: Router.getTokenRequest, handler: completion)
    }

    func login(username: String, password: String, completion: @escaping ApiResponseGeneric<LoginData>) {
        apiManager.sendRequest(type: Router.login(username: username, password: password), handler: completion)
    }

    func getSession(completion: @escaping ApiResponseGeneric<SessionData>) {
        apiManager.sendRequest(type: Router.createSession, handler: completion)
    }

    func getUser(completion: @escaping ApiResponseGeneric<User>) {
        apiManager.sendRequest(type: Router.getUserAccountDetails, handler: completion)
    }
}

class SingleMovieService {
    let apiManger = APIManager()

    func getSingleMovie(movieId: Int?, completion: @escaping ApiResponseGeneric<Movie>) {
        if let movieId = movieId {
            apiManger.sendRequest(type: Router.getSingleMovie(movieId: movieId), handler: completion)
        }
    }

    func getSingleMovieReviews(movieId: Int?, completion: @escaping ApiResponseGeneric<MovieReviews>) {
        if let movieId = movieId {
            apiManger.sendRequest(type: Router.getSingleMovieReviews(movieId: movieId), handler: completion)
        }
    }

    func addToWatchList(add: Bool, userId: Int?, movieId: Int, completion: @escaping ApiResponseGeneric<LoginData>) {
        if let userId = userId {
            apiManger.sendRequest(type: Router.addToWatchList(add: add, userId: userId, movieId: movieId), handler: completion)
        }
    }
    
    func getCastAndCrew(movieId: Int?,  completion: @escaping ApiResponseGeneric<CastAndCrew>) {
        if let movieId = movieId {
            apiManger.sendRequest(type: Router.getCastAndCrew(movieId: movieId), handler: completion)
        }
    }
}

class WatchListService {
    let apiManger = APIManager()

    func getWatchList(userId: Int?, completion: @escaping ApiResponseGeneric<TrendingMovie>) {
        if let userId = userId {
            apiManger.sendRequest(type: Router.getWatchList(userId: userId), handler: completion)
        }
    }
}

class SearchService {
    let apiManger = APIManager()

    func search(query: String, completion: @escaping ApiResponseGeneric<TrendingMovie>) {
        apiManger.sendRequest(type: Router.search(query: query), handler: completion)
    }
}

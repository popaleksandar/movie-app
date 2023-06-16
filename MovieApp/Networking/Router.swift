//
//  Router.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/11/22.
//

import Alamofire
import Foundation

enum Router {
    case getTokenRequest
    case login(username: String, password: String)
    case createSession
    case getUserAccountDetails
    case getNowPlayingMovies
    case getPopularMovies
    case getTopRatedMovies
    case getLatestMovies
    case getUpcomingMovies
    case getSingleMovie(movieId: Int)
    case getSingleMovieReviews(movieId: Int)
    case getWatchList(userId: Int)
    case addToWatchList(add: Bool, userId: Int, movieId: Int)
    case search(query: String)
    case getCastAndCrew(movieId: Int)
}

extension Router: EndPointType {
    var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    var path: String {
        switch self {
        case .getTokenRequest:
            return "/authentication/token/new"
        case .login:
            return "/authentication/token/validate_with_login"
        case .createSession:
            return "/authentication/session/new"
        case .getUserAccountDetails:
            return "/account"
        case .getNowPlayingMovies:
            return "/movie/now_playing"
        case .getPopularMovies:
            return"/movie/popular"
        case .getTopRatedMovies:
            return "/movie/top_rated"
        case .getLatestMovies:
            return "/movie/latest"
        case .getUpcomingMovies:
            return "/movie/upcoming"
        case .getSingleMovie(let movieId):
            return "/movie/\(movieId)"
        case .getSingleMovieReviews(let movieId):
            return "/movie/\(movieId)/reviews"
        case .getWatchList(let userId):
            return "/account/\(userId)/favorite/movies"
        case .addToWatchList(_, let userId, _):
            return "/account/\(userId)/favorite"
        case .search:
            return "/search/movie"
        case .getCastAndCrew(let movieId):
            return "/movie/\(movieId)/credits"
        }
    }
    
    var httpMethod: Alamofire.HTTPMethod {
        switch self {
        case .getTokenRequest, .getNowPlayingMovies, .getPopularMovies, .getTopRatedMovies, .getLatestMovies, .getUpcomingMovies, .getSingleMovie, .getSingleMovieReviews, .getUserAccountDetails, .getWatchList, .search, .getCastAndCrew:
            return .get
        case .login, .createSession, .addToWatchList:
            return .post
        }
    }
    
    var url: URL {
        return URL(string: baseURL + path)!
    }
    
    var headers: Alamofire.HTTPHeaders {
        switch self {
        case .getTokenRequest, .login, .createSession, .getNowPlayingMovies, .getPopularMovies, .getTopRatedMovies, .getLatestMovies, .getUpcomingMovies, .getSingleMovie, .getSingleMovieReviews, .getUserAccountDetails, .getWatchList, .search, .getCastAndCrew:
            return ["Accept": "*/*",
                    "Accept-Encoding": "gzip, deflate, br"]
        case .addToWatchList:
            return ["Accept": "*/*",
                    "Accept-Encoding": "gzip, deflate, br",
                    "Content-Type": "application/json;charset=utf-8"]
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getTokenRequest, .getNowPlayingMovies, .getPopularMovies, .getTopRatedMovies, .getLatestMovies, .getUpcomingMovies, .getSingleMovie, .getSingleMovieReviews, .getCastAndCrew:
            return ["api_key": "63d8eb401fc3c463f4adc17683be5160",
                    "language": "en-US"]
        case .login(let username, let password):
            return ["username": username,
                    "password": password,
                    "api_key": "63d8eb401fc3c463f4adc17683be5160",
                    "request_token": UserDefaults.standard.string(forKey: "request_token") ?? ""]
        case .createSession:
            print(UserDefaults.standard.object(forKey: "request_token") as? String ?? "")
            return ["api_key": "63d8eb401fc3c463f4adc17683be5160",
                    "request_token": UserDefaults.standard.object(forKey: "request_token") as? String ?? ""]
        case .getUserAccountDetails, .getWatchList:
            return ["api_key": "63d8eb401fc3c463f4adc17683be5160",
                    "session_id": UserDefaults.standard.object(forKey: "session_id") as? String ?? ""]
        case .addToWatchList(let add, _, let movieId):
            return ["api_key": "63d8eb401fc3c463f4adc17683be5160",
                    "session_id": UserDefaults.standard.object(forKey: "session_id") as? String ?? "",
                    "media_type": "movie", "media_id": movieId, "favorite": add]
        case .search(let query):
            return ["api_key": "63d8eb401fc3c463f4adc17683be5160",
                    "query": query,
                    ]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .login, .createSession, .addToWatchList:
            return URLEncoding.queryString
        default:
            return URLEncoding.default
        }
    }

    func asURLRequest() throws -> URLRequest {
        var request = try URLRequest(url: url, method: httpMethod)
        request.headers = headers
        return try encoding.encode(request, with: parameters)
    }
}

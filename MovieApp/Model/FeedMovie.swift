//
//  FeedMovie.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 11/1/22.
//

import Foundation


struct FeedMovie: Codable {
    let id: Int?
    let title: String?
    let vote_average: Float?
    let release_date: String?
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
    let popularity: Float?
}

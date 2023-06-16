//
//  Movie.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/10/22.
//

import Foundation


struct Movie: Codable {
    let id: Int?
    let title: String?
    let vote_average: Float?
    let release_date: String?
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
    let genres: [Genre]
    let runtime: Int?
    let popularity: Float?
}

struct Genre: Codable {
    let id: Int
    let name: String
}

//
//  SingleMovieReview.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 11/1/22.
//

import Foundation

struct SingleMovieReview: Codable {
    let author: String?
    let author_details: AuthorDetails?
    let content: String? 
}

struct AuthorDetails: Codable {
    let avatar_path: String?
    let username: String?
    let rating: Float?
}

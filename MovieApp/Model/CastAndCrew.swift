//
//  CastAndCrew.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 11/4/22.
//

import Foundation

struct CastAndCrew: Codable {
    let id: Int?
    let cast: [Cast]?
}

struct Cast: Codable {
    let name: String?
    let character: String?
}


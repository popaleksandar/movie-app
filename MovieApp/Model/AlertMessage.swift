//
//  AlertMessage.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/10/22.
//

import Foundation

struct AlertMessage: Codable, Error {
    var title: String
    var message: String
}

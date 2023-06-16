//
//  LoginData.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/27/22.
//

import Foundation


struct LoginData: Codable {
    let success: Bool
    let expires_at: String?
    let request_token: String?
    let status_code: Int?
    let status_message: String?
}

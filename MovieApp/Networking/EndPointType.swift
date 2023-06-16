//
//  EndPointType.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/10/22.
//

import Alamofire

protocol EndPointType: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var url: URL { get }
    var headers: HTTPHeaders { get }
    var encoding: ParameterEncoding { get }
}

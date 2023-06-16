//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 11/2/22.
//

import Foundation

class SearchViewModel {
    let searchService = SearchService()
    var dataSource: [FeedMovie] = []

    func search(query: String, completion: @escaping (Bool, Error?) -> ()) {
        searchService.search(query: query, completion: { [weak self] result in
            switch result {
            case .success(let movies):
                self?.dataSource = movies.results
                completion(true, nil)
            case .failure(let error):
                print(error)
                completion(false, error)
            }

        })
    }
}

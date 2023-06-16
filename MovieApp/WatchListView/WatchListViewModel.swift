//
//  WatchListViewModel.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 11/2/22.
//

import CoreData
import Foundation

class WatchListViewModel {
    let watchListService = WatchListService()
    let dataStack = CoreDataStack(modelName: "WatchListMovie")
    var dataSource: [FeedMovie] = []

    func getWatchList(completion: @escaping (Bool, Error?) -> ()) {
        let context = dataStack.managedContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dataStack.modelName)
        if let result = try? context.fetch(request) as? [NSManagedObject] {
            var tmpArray: [FeedMovie] = []
            for object in result {
                let wtchMovie = FeedMovie(id: object.value(forKey: "movieId") as? Int, title: object.value(forKey: "title") as? String, vote_average: object.value(forKey: "vote_average") as? Float, release_date: object.value(forKey: "release_date") as? String, overview: object.value(forKey: "overview") as? String, poster_path: object.value(forKey: "poster_path") as? String, backdrop_path: object.value(forKey: "backdrop_path") as? String, popularity: object.value(forKey: "popularity") as? Float)
                tmpArray.append(wtchMovie)
            }
            dataSource = tmpArray
            completion(true, nil)
        }
    }
}

//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/31/22.
//

import CoreData
import Foundation

class MovieDetailViewModel {
    let singleMovieService = SingleMovieService()
    let dataStack = CoreDataStack(modelName: "WatchListMovie")
    var movieId: Int?
    var movieDetails: Movie?
    var moviewReviews: MovieReviews?
    var movieCastAndCrew: [Cast]?
    
    func getMovieDetails(completion: @escaping (Bool, Error?) -> ()) {
        singleMovieService.getSingleMovie(movieId: movieId, completion: { result in
            switch result {
            case .success(let movie):
                self.movieDetails = movie
                completion(true, nil)
            case .failure(let error):
                print(error)
                completion(false, error)
            }
        })
    }
    
    func getMovieReviews(completion: @escaping (Bool, Error?) -> ()) {
        singleMovieService.getSingleMovieReviews(movieId: movieId, completion: { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.moviewReviews = reviews
                completion(true, nil)
            case .failure(let error):
                print(error)
                completion(false, error)
            }
        })
    }
    
    func getCastAndCrew(completion: @escaping (Bool, Error?) -> ()) {
        singleMovieService.getCastAndCrew(movieId: movieId, completion: { [weak self] result in
            switch result {
            case .success(let castAndCrew):
                self?.movieCastAndCrew = castAndCrew.cast
                completion(true, nil)
            case .failure(let error):
                print(error)
                completion(false, error)
            }
        })
    }
    
    func addToWatchList(completion: @escaping (Bool, Error?) -> ()) {
        if let movieId = movieId {
            singleMovieService.addToWatchList(add: true, userId: UserDefaults.standard.object(forKey: "user_id") as? Int, movieId: movieId, completion: { result in
                switch result {
                case .success(let success):
                    if success.success == true {
                        if self.addToLocalWatchList(movie: self.movieDetails) == true {
                            completion(true, nil)
                        }
                    } else {
                        completion(false, nil)
                    }
                case .failure(let error):
                    completion(false, error)
                }
            })
        }
    }
    
    func removeFromWatchList(completion: @escaping (Bool, Error?) -> ()) {
        if let movieId = movieId {
            singleMovieService.addToWatchList(add: false, userId: UserDefaults.standard.object(forKey: "user_id") as? Int, movieId: movieId, completion: { result in
                switch result {
                case .success(let success):
                    if success.success == true {
                        if self.removeFromWatchList(id: movieId) == true {
                            completion(true, nil)
                        }
                    } else {
                        completion(false, nil)
                    }
                case .failure(let error):
                    completion(false, error)
                }
            })
        }
    }
    
    private func addToLocalWatchList(movie: Movie?) -> Bool {
        if let movie = movie {
            let entity = NSEntityDescription.entity(forEntityName: dataStack.modelName, in: dataStack.managedContext)
            let newMovie = NSManagedObject(entity: entity!, insertInto: dataStack.managedContext)
            newMovie.setValue(movie.id, forKey: "movieId")
            newMovie.setValue(movie.poster_path, forKey: "poster_path")
            newMovie.setValue(movie.release_date, forKey: "release_date")
            newMovie.setValue(movie.vote_average, forKey: "vote_average")
            newMovie.setValue(movie.vote_average, forKey: "popularity")
            do {
                try dataStack.managedContext.save()
                return true
            } catch {
                print("Error saving")
                return false
            }
        }
        return false
    }
    
    private func removeFromWatchList(id: Int?) -> Bool {
        if let id = id {
            let context = dataStack.managedContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: dataStack.modelName)
            if let result = try? context.fetch(request) as? [NSManagedObject] {
                for object in result {
                    if object.value(forKey: "movieId") as? Int == id {
                        context.delete(object)
                    }
                }
            }
            do {
                try context.save()
                return true
            } catch {
                fatalError("crklo")
            }
        }
        return false
    }
    
    func isEntityAttributeExist(id: Int?) -> Bool {
        if let id = id {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: dataStack.modelName)
            request.returnsObjectsAsFaults = false
            do {
                let result = try dataStack.managedContext.fetch(request) as! [NSManagedObject]
                print(result)
                for object in result {
                    if object.value(forKey: "movieId") as? Int == id {
                        return true
                    }
                }
                return false
            } catch {
                fatalError("errored")
            }
        }
        return false
    }
}

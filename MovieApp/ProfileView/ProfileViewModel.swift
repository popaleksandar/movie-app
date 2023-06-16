//
//  ProfileViewModel.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 11/3/22.
//

import Foundation

class ProfileViewModel {
    let authService = AuthService()
    var dataSource: User?

    func getUser(completion: @escaping (Bool, Error?) -> ()) {
        authService.getUser(completion: { result in
            switch result {
            case .success(let user):
                self.dataSource = user
                completion(true, nil)
            case .failure(let error):
                print(error)
                completion(false, error)
            }
        })
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "user_id")
        UserDefaults.standard.removeObject(forKey: "session_id")
        UserDefaults.standard.removeObject(forKey: "request_token")
        UserDefaults.standard.synchronize()
    }
}

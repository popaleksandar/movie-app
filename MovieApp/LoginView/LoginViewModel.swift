//
//  LoginViewModel.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/27/22.
//

import Foundation

class LoginViewModel {
    let authService = AuthService()

    func login(username: String, password: String, completion: @escaping (Bool, Error?) -> ()) {
        authService.getRequestToken(completion: { [weak self] result in
            switch result {
            case .success(let data):
                UserDefaults.standard.set(data.request_token, forKey: "request_token")
                UserDefaults.standard.set(data.expires_at, forKey: "expires_at")
                self?.authService.login(username: username, password: password, completion: { result in
                    switch result {
                    case .success(let data):
                        if data.success == true {
                            completion(true, nil)
                            print(data)
                        } else { completion(false, nil) }
                    case .failure(let error):
                        completion(false, error)
                        print(error)
                    }

                })
            case .failure(let error):
                completion(false, error)
            }
        })
    }

    func getSession(completion: @escaping (Bool, Error?) -> ()) {
        authService.getSession(completion: { result in
            switch result {
            case .success(let data):
                if data.success == true {
                    UserDefaults.standard.set(data.session_id, forKey: "session_id")
                    completion(true, nil)
                    print(data)
                } else { completion(false, nil) }
            case .failure(let error):
                completion(false, error)
            }

        })
    }

    func getUser() {
        authService.getUser(completion: { result in
            switch result {
            case .success(let user):
                UserDefaults.standard.set(user.id, forKey: "user_id")
                UserDefaults.standard.set(user.username, forKey: "username")
                UserDefaults.standard.set(user.name ?? "", forKey: "users_name")
            case .failure(let error):
                print(error)
            }

        })
    }
}

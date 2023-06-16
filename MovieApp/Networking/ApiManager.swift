//
//  ApiManager.swift
//  MovieApp
//
//  Created by Aleksandar Popovic on 10/10/22.
//

import Alamofire
import Foundation

typealias ApiResponseGeneric<T> = (Result<T, AlertMessage>) -> Void

class APIManager {
    private var sessionManager = Session()
    
    init() {
        self.sessionManager = Session()
    }
    
    func sendRequest<T>(type: EndPointType, handler: @escaping ApiResponseGeneric<T>) where T: Codable {
        print(type)
        AF.request(type).responseJSON { data in // ok
            DispatchQueue(label: "", qos: .userInitiated).async {
                switch data.result {
                case .success:
                    let decoder = JSONDecoder()
                    print(data)
                    if let jsonData = data.data {
                        do {
                            let result = try decoder.decode(T.self, from: jsonData)
                            DispatchQueue.main.async {
                                handler(.success(result))
                            }
                        } catch let parsingError {
                            print(parsingError)
                            DispatchQueue.main.async {
                                handler(.failure(AlertMessage(title: "Ne isparsira", message: "nez brz")))
                            }
                        }
                    }
                    
                case .failure:
                    DispatchQueue.main.async {
                        handler(.failure(AlertMessage(title: "Ne radi", message: "nez brz")))
                    }
                }
            }
        }
    }
}

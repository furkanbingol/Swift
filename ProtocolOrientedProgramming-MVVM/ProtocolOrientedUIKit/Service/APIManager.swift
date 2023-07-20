//
//  APIManager.swift
//  ProtocolOrientedUIKit
//
//  Created by Furkan Bingöl on 20.07.2023.
//

import Foundation

// APIManager, UserService protocolünü conform etti.
final class APIManager: UserService {
    //static let shared = APIManager()
    //private init() { }
    
    func fetchUserDatas(completion: @escaping (Result<User,Error>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let _ = response,
                  error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                if let user = try? JSONDecoder().decode([User].self, from: data).first {    // We want a user, not array of users
                    completion(.success(user))
                } else {
                    completion(.failure(NSError()))
                }
            }
        }
        
        task.resume()
    }
 
}

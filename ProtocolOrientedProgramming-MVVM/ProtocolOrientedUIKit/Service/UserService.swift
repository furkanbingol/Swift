//
//  UserService.swift
//  ProtocolOrientedUIKit
//
//  Created by Furkan Bingöl on 20.07.2023.
//

import Foundation

protocol UserService {
    func fetchUserDatas(completion: @escaping (Result<User,Error>) -> Void)
}

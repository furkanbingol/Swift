//
//  UserSingleton.swift
//  SnapchatCloneFirebase
//
//  Created by Furkan Bingöl on 16.07.2023.
//

import Foundation

// Singleton Class
class UserSingleton {
    static let shared = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init() { }
}

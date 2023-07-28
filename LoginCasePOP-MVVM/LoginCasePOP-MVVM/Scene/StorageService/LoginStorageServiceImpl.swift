//
//  LoginStorageServiceImpl.swift
//  LoginCasePOP-MVVM
//
//  Created by Furkan Bingöl on 28.07.2023.
//

import Foundation

// LoginStorageService'i implemente eden class --> LoginStorageServiceImpl
class LoginStorageServiceImpl: LoginStorageService{
    
    private let storage = UserDefaults.standard
    
    var userAccessTokenKey: String {
        return "ACCESS_TOKEN"
    }
    
    func setUserAccessToken(token: String) {
        storage.set(token, forKey: userAccessTokenKey)
    }
    
    func getUserAccessToken() -> String? {
        return storage.string(forKey: userAccessTokenKey)
    }
    
    
}

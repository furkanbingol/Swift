//
//  LoginStorageService.swift
//  LoginCasePOP-MVVM
//
//  Created by Furkan Bingöl on 28.07.2023.
//

import Foundation

protocol LoginStorageService {
    var userAccessTokenKey: String { get }
    func setUserAccessToken(token: String)
    func getUserAccessToken() -> String?
}

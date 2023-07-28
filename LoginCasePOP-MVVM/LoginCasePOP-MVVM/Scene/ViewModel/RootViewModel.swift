//
//  RootViewModel.swift
//  LoginCasePOP-MVVM
//
//  Created by Furkan Bingöl on 28.07.2023.
//

import UIKit

class RootViewModel {
    
    private let loginStorageService: LoginStorageService
    weak var output: RootViewModelOutput?    // Delegate
    
    init(loginStorageService: LoginStorageService) {
        self.loginStorageService = loginStorageService
    }
    
    func checkLogin() {
        if let accessToken = loginStorageService.getUserAccessToken(),
           !accessToken.isEmpty {
            // Login success
            self.output?.showMainApp()
        } else {
            // Login fail
            self.output?.showLogin()
        }
    }
    
}

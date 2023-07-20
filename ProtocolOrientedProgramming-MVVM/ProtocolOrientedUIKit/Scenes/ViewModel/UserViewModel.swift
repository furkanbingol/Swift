//
//  UserViewModel.swift
//  ProtocolOrientedUIKit
//
//  Created by Furkan Bingöl on 20.07.2023.
//

import Foundation

class UserViewModel {
    
    private let userService: UserService     // Dependency Injection gibi, "protocolü enjekt ettik".
    weak var output: UserViewModelOutput?    // viewModel ile view arasındaki etkileşimi kurabilmek için "Delegate Pattern" kullandık.
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    
    func fetchUsers() {
        userService.fetchUserDatas { [weak self] result in
            switch result {
            case .success(let user):
                self?.output?.updateView(name: user.name, username: user.username, email: user.email)
            case .failure:
                self?.output?.updateView(name: "No user", username: "", email: "")
            }
        }
    }
    
}

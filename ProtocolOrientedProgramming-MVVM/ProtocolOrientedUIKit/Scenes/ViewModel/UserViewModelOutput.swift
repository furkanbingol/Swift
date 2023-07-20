//
//  UserViewModelOutput.swift
//  ProtocolOrientedUIKit
//
//  Created by Furkan Bingöl on 20.07.2023.
//

import Foundation

protocol UserViewModelOutput: AnyObject {
    func updateView(name: String, username: String, email: String)
}

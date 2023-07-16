//
//  Snap.swift
//  SnapchatCloneFirebase
//
//  Created by Furkan Bingöl on 16.07.2023.
//

import Foundation

class Snap {
    var username: String
    var imageUrlArray: [String]
    var date: Date
    
    init(username: String, imageUrlArray: [String], date: Date) {
        self.username = username
        self.imageUrlArray = imageUrlArray
        self.date = date
    }
}

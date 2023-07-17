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
    var timeDifference: Int
    
    init(username: String, imageUrlArray: [String], date: Date, timeDifference: Int) {
        self.username = username
        self.imageUrlArray = imageUrlArray
        self.date = date
        self.timeDifference = timeDifference
    }
}

//
//  RoomType.swift
//  HotelCalifornia
//
//  Created by Furkan Bingöl on 2.03.2023.
//

import Foundation

struct RoomType: Equatable {
    
    // MARK: - Properties
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    // MARK: - Functions
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {     //Equatable protocolündeki '== metodunu' override ettik
        return lhs.id == rhs.id
    }
    
    static var all: [RoomType] {    //get-only, static property
        return [
            RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
            RoomType(id: 1, name: "One King", shortName: "K", price: 209),
            RoomType(id: 2, name: "Suit", shortName: "S", price: 309)
        ]
    }
}


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
}

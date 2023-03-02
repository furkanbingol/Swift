//
//  Registration.swift
//  HotelCalifornia
//
//  Created by Furkan Bingöl on 2.03.2023.
//

import Foundation

struct Registration {
    
    // MARK: - Properties
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
}

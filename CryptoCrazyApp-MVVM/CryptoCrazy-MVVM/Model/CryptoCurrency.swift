//
//  CryptoCurrency.swift
//  CryptoCrazy-MVVM
//
//  Created by Furkan Bingöl on 21.06.2023.
//

import Foundation

// Codable = (Decodable & Encodable)
// Encodable --> POST
// Decodable --> GET
struct CryptoCurrency: Decodable {
    let currency: String
    let price: String
}

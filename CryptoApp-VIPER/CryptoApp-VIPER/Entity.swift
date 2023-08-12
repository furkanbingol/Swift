//
//  Entity.swift
//  CryptoApp-VIPER
//
//  Created by Furkan Bingöl on 12.08.2023.
//

import UIKit

// MARK: - Model
struct Crypto: Decodable {
    let currency: String
    let price: String
}

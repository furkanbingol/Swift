//
//  TestFile.swift
//  DependencyInjection
//
//  Created by Furkan Bingöl on 14.07.2023.
//

import Foundation

struct Instrument {
    var name: String
    var brand: String
}

struct Band {
    var name: String
}

struct Musician {
    var name: String
    var age: Int
    var instrument: Instrument
    var band: Band
}

let jamesBand = Band(name: "")
let guitar = Instrument(name: "", brand: "")
let james = Musician(name: "", age: 22, instrument: guitar, band: jamesBand)
// Musician, Instrument ve Band'e bagımlı (dependent).

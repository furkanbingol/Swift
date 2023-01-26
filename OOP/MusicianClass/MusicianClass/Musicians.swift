//
//  Musicians.swift
//  MusicianClass
//
//  Created by Furkan Bingöl on 26.01.2023.
//

import Foundation


enum MusicianType {
    case LeadGuitar
    case Vocalist
    case Drummer
    case Bassist
    case Violenist
    case Pianist
}


class Musicians  {
    
    //Properties
    var name : String
    var age : Int
    var instrument : String
    var type : MusicianType
    
    //Initializer --> Constructor
    init(name: String, age: Int, instrument: String, type: MusicianType) {
        self.name = name
        self.age = age
        self.instrument = instrument
        self.type = type
    }
    
    //Methods
    func sing(){
        print("Singing in 'Musicians' class!")
    }
}

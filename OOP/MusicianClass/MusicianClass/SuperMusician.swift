//
//  SuperMusician.swift
//  MusicianClass
//
//  Created by Furkan Bingöl on 26.01.2023.
//

import Foundation

//Inheritance
class SuperMusician : Musicians {
    
    override func sing() {
        super.sing()     //calling parent(Musicians Class)'s sing() method
        print("Singing in 'SuperMusician' class!")     //own sing() method
    }
    
}

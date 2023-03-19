//
//  Model.swift
//  RetainCycle&ARC
//
//  Created by Furkan Bingöl on 19.03.2023.
//

import Foundation

class Person {
    
    var name: String
    var macbook: MacBook?
    
    init(name: String, macbook: MacBook?) {
        self.name = name
        self.macbook = macbook
    }
    
    // Memoryden silinirken çalışır. --> deinit
    deinit {
        print("\(name) is being deinitialized!")
    }
}


class MacBook {
    
    var name: String
    var owner: Person?
    
    init(name: String, owner: Person?) {
        self.name = name
        self.owner = owner
    }
    
    // Memoryden silinirken çalışır. --> deinit
    deinit {
        print("Macbook named \(name) is being deinitialized!")
    }
}


class Person2 {
    
    var name: String
    var macbook: MacBook2?
    
    init(name: String, macbook: MacBook2?) {
        self.name = name
        self.macbook = macbook
    }
    
    deinit {
        print("\(name) is being deinitialized! Person2 deinit!")
    }
}


class MacBook2 {
    
    var name: String
    weak var owner: Person2?         // Person objesini tutan değişkeni 'weak' yaptık.
    
    init(name: String, owner: Person2?) {
        self.name = name
        self.owner = owner
    }
    
    deinit {
        print("Macbook named \(name) is being deinitialized! MacBook2 deinit!")
    }
}

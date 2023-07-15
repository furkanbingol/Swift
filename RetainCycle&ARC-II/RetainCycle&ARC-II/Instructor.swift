//
//  Instructor.swift
//  RetainCycle&ARC-II
//
//  Created by Furkan Bingöl on 15.07.2023.
//

import Foundation

class Instructor {
    let name: String
    var course: Course?
    
    init(name: String) {
        self.name = name
    }
    
    // Memory'den silinirken çalışan blok -> deinit
    deinit {
        print("Instructor \(name) deinitialized!")
    }
}


class Course {
    let name: String
    let url: URL
    var instructor: Instructor?
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
    
    // Memory'den silinirken çalışan blok -> deinit
    deinit {
        print("Course \(name) deinitialized!")
    }
}

//
//  WeakInstructor.swift
//  RetainCycle&ARC-II
//
//  Created by Furkan Bingöl on 15.07.2023.
//

import Foundation

class WeakInstructor {
    let name: String
    var course: WeakCourse?
    
    init(name: String) {
        self.name = name
    }
    
    // Memory'den silinirken çalışan blok -> deinit
    deinit {
        print("WeakInstructor \(name) deinitialized!")
    }
}


class WeakCourse {
    let name: String
    let url: URL
    weak var instructor: WeakInstructor?        // 'weak' yaptık!
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
    
    // Memory'den silinirken çalışan blok -> deinit
    deinit {
        print("WeakCourse \(name) deinitialized!")
    }
}

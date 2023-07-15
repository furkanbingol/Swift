//
//  WeakSelfExample.swift
//  RetainCycle&ARC-II
//
//  Created by Furkan Bingöl on 15.07.2023.
//

import Foundation

struct LaunchedCourse {
    let title: String
    var isLaunch: Bool = false
    
    init(title: String) {
        self.title = title
    }
}

class WeakSelfInstructor {
    let name: String
    var course: WeakSelfCourse?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("WeakSelfInstructor \(name) deinitialized!")
    }
}


class WeakSelfCourse {
    let name: String
    let url: URL
    weak var instructor: WeakSelfInstructor?
    
    var launchedCourses: [LaunchedCourse] = []
    var onLaunched: ((_ launchedCourse: LaunchedCourse) -> Void)?     // closure
    
    func launch(launchedCourse: LaunchedCourse) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.launchedCourses.append(launchedCourse)
            print("launched course count: \(self.launchedCourses.count)")
        }
    }
    
    func launchWithWeakSelf(launchedCourse: LaunchedCourse) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.onLaunched?(launchedCourse)
        }
    }
    
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
        
        onLaunched = { [weak self] launchedCourses in
            self?.launchedCourses.append(launchedCourses)
            print("launched course count: \(self?.launchedCourses.count)")
        }
    }
    
    deinit {
        print("WeakSelfCourse \(name) deinitialized!")
    }
}

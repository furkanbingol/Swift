//
//  ViewController.swift
//  RetainCycle&ARC-II
//
//  Created by Furkan Bingöl on 15.07.2023.
//

import UIKit


final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // runStrongReferenceExample()
        // runWeakReferenceExample()
        runWeakSelfExample()
    }
    
    
    private func runStrongReferenceExample() {
        var course: Course? = Course(name: "iOS Course", url: URL(string: "example")!)
        var instructor: Instructor? = Instructor(name: "Furkan Bingol")
        
        // DEINIT RUNS!
        // course = nil       // deinit runs
        // instructor = nil
        
        course?.instructor = instructor
        instructor?.course = course
        course = nil
        instructor = nil
        // DEINIT NOT RUNS! --> Strong Reference oldugu icin (Retain Cycle, referanslar birbirlerini tutuyorlar)
    }
    
    
    private func runWeakReferenceExample() {
        var course: WeakCourse? = WeakCourse(name: "iOS", url: URL(string: "example")!)
        var instructor: WeakInstructor? = WeakInstructor(name: "Furkan Bingol")
        
        // DEINIT RUNS!
        // course = nil       // deinit runs
        // instructor = nil
        
        course?.instructor = instructor
        instructor?.course = course
        course = nil
        instructor = nil
        // DEINIT RUNS! --> Weak reference oldugu icin, bir referansın deinit olması diğer referansında deinit olmasını saglar.
    }
    
    
    private func runWeakSelfExample() {
        var course: WeakSelfCourse? = WeakSelfCourse(name: "iOS", url: URL(string: "example")!)
        var instructor: WeakSelfInstructor? = WeakSelfInstructor(name: "Furkan Bingol")
                
        course?.instructor = instructor
        instructor?.course = course
        
        // course?.launch(launchedCourse: LaunchedCourse(title: "iOS"))
        /*
         WeakSelfInstructor Furkan Bingol deinitialized!
         launched course count: 1               <------------
         WeakSelfCourse iOS deinitialized!
        */
        
        
        course?.launchWithWeakSelf(launchedCourse: LaunchedCourse(title: "Android"))
        /*
         WeakSelfInstructor Furkan Bingol deinitialized!
         launched course count: Optional(1)     <------------
         WeakSelfCourse iOS deinitialized!
        */
        
        course = nil
        instructor = nil
    }

}


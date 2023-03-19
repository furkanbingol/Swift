//
//  ViewController.swift
//  RetainCycle&ARC
//
//  Created by Furkan Bingöl on 19.03.2023.
//

import UIKit

/*
 Retain Cycle: Bir instance'in memory'de Tutulma Döngüsü.
 ARC: Automatic Reference Counting. Memory Management için kullanılan bir teknoloji.
*/

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var furkan: Person?
    var matilda: MacBook?
    var newFurkan: Person2?
    var newMacbook: MacBook2?
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createObjects()
        //assignPropertiesAndDeinitInstance()
        assignPropertiesWithWeakPropertyAndDeinitInstance()
    }
    
    
    // MARK: - Functions
    
    func createObjects() {
        furkan = Person(name: "Furkan", macbook: nil)
        matilda = MacBook(name: "Matilda", owner: nil)
        
        // furkan = nil     // Furkan is being deinitialized!
        // matilda = nil    // Macbook named Matilda is being deinitialized!
        
        newFurkan = Person2(name: "newFurkan", macbook: nil)
        newMacbook = MacBook2(name: "newMacbook", owner: nil)
    }
    
    
    func assignPropertiesAndDeinitInstance() {
        furkan?.macbook = matilda
        matilda?.owner = furkan
        
        furkan = nil
        // Deinit çalışmayacak. Çünkü "STRONG REFERENCE" var. matilda.owner ile furkan'ı tutuyor.
        // ARC 0 olmadığı için furkan deinit edilemeyecek!
    }
    
    
    func assignPropertiesWithWeakPropertyAndDeinitInstance() {
        newFurkan?.macbook = newMacbook
        newMacbook?.owner = newFurkan
        
        newFurkan = nil
        // Deinit çalışacak. Çünkü "WEAK REFERENCE" var. newMacbook.owner, newFurkan'ı weak bir şekilde tutuyor.
        // ARC 0 olacağı için newFurkan deinit edilecek!
    }
    
}


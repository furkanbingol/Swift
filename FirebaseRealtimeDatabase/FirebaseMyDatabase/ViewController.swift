//
//  ViewController.swift
//  FirebaseMyDatabase
//
//  Created by Furkan Bingöl on 28.03.2023.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    // Bir tane instance oluşturduk. Bu instance üzerinden database üzerinde işlemler yapacağız.
    private let database = Database.database().reference()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetching data from database
        database.child("something15").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String : Any] else {
                return
            }
            
            print("Returning value: \(value)")
        }
        
        let button = UIButton(frame: CGRect(x: 20, y: 200, width: view.frame.size.width - 40, height: 50))
        button.setTitle("Add Entry", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(addNewEntry), for: .touchUpInside)
    }

    
    @objc private func addNewEntry() {
        let object: [String : Any] = [
            "name": "Furkan" as NSObject,
            "Youtube": "no"
        ]

        // Firebase - Realtime Database
        database.child("something\(Int.random(in: 0..<100))").setValue(object)
        // in JSON Tree: key(something) - value(object)
        // key must be UNIQUE
        // key == child
    }

}


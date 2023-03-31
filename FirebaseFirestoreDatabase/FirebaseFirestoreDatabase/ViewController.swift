//
//  ViewController.swift
//  FirebaseFirestoreDatabase
//
//  Created by Furkan Bingöl on 29.03.2023.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController, UITextFieldDelegate {

    let database = Firestore.firestore()
    
    
    // MARK: - UI Elements
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter text..."
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        return field
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.addSubview(field)
        field.delegate = self
        
        // Reading Data from database
        let docRef = database.document("myProject/example")
//        docRef.getDocument { [weak self] snapshot, error in
//            guard let data = snapshot?.data(), error == nil else {
//                return
//            }
//
//            guard let text = data["text"] as? String else {
//                return
//            }
//
//            // UI işlemi mainQueue'da olmalı
//            DispatchQueue.main.async {
//                self?.label.text = text
//            }
//            print(data)
//        }
        
        // Veriyi her zaman okumasını istiyorsak, "OBSERVER-snapshotListener" eklemeliyiz. Firestore tarafında değişiklik olduğu zaman, bizim ARAYÜZE o değişikliği yansıtacak.
        docRef.addSnapshotListener { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            guard let text = data["text"] as? String else {
                return
            }
            
            // UI işlemi mainQueue'da olmalı
            DispatchQueue.main.async {
                self?.label.text = text
            }
            print(data)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        field.frame = CGRect(x: 10, y: view.safeAreaInsets.top + 10, width: view.frame.size.width - 20, height: 50)
        label.frame = CGRect(x: 10, y: view.safeAreaInsets.top + 10 + 60, width: view.frame.size.width - 20, height: 100)
    }

    
    // Saving data to database
    func saveData(text: String) {
        let docRef = database.document("myProject/example")
        // myProject --> Collection
        // example --> Document
        
        docRef.setData(["text" : text])
    }
    
    
    // TextField Delegate Function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Enter'a bastığımızda klavyeden(Butonda olabilirdi), veriyi kaydetmeliyiz.
        if let text = textField.text, !text.isEmpty {
            saveData(text: text)
        }
        return true
    }
}


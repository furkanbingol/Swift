//
//  SettingsViewController.swift
//  InstaCloneFirebase
//
//  Created by Furkan Bingöl on 29.03.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    // MARK: - UI Elements
    
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Functions
    
    
    // MARK: - Actions
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
    
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        }
        catch {
            print("Error")
        }
    }
    
}

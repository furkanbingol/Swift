//
//  SettingsVC.swift
//  SnapchatCloneFirebase
//
//  Created by Furkan Bingöl on 15.07.2023.
//

import UIKit
import Firebase

final class SettingsVC: UIViewController {

    // MARK: - UI Elements
    
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Functions
    @IBAction func logoutTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .cancel)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { action in
            do {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: "toSignInVC", sender: nil)
            } catch {
                print("error")
            }
        }
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        present(alert, animated: true)
    }
    
}

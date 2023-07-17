//
//  SignInVC.swift
//  SnapchatCloneFirebase
//
//  Created by Furkan Bingöl on 15.07.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

final class SignInVC: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField! {
        willSet {
            newValue.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var eyeButton: UIButton! {
        willSet {
            newValue.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    
    // MARK: - Properties
    let firestore = Firestore.firestore()
    var eyeButtonIsTapped = false
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For keyboard dismiss
        view.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func keyboardDismiss(){
        view.endEditing(true)
    }
    
    
    // MARK: - Functions
    @IBAction func signInClicked(_ sender: UIButton) {
        guard let email = emailTextField.text, email != "" else {
            makeAlert(title: "Error", message: "Missing email!")
            return
        }
        guard let password = passwordTextField.text, password != "" else {
            makeAlert(title: "Error", message: "Missing password!")
            return
        }
        // "guard let username = usernameTextField.text" is not necessary for this signIn case.
        
        // SignIn authenticate via Auth.auth()
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard let _ = result, error == nil else {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
                return
            }
            
            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
        }
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        guard let email = emailTextField.text, email != "" else {
            makeAlert(title: "Error", message: "Missing email!")
            return
        }
        guard let username = usernameTextField.text, username != "" else {
            makeAlert(title: "Error", message: "Missing username!")
            return
        }
        guard let password = passwordTextField.text, password != "" else {
            makeAlert(title: "Error", message: "Missing password!")
            return
        }
        
        // Creating user
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let _ = result, error == nil else {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
                return
            }
            
            let userDictionary = ["email": email, "username": username] as! [String : Any]
            
            // Saving user infos to firestore database
            self.firestore.collection("UserInfo").addDocument(data: userDictionary) { error in
                guard error == nil else {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
                    return
                }
            }
            
            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
        }
    }
    
    @IBAction func eyeButtonTapped(_ sender: UIButton) {
        eyeButtonIsTapped.toggle()
        
        if eyeButtonIsTapped {
            eyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            passwordTextField.isSecureTextEntry = false
        } else {
            eyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            passwordTextField.isSecureTextEntry = true
        }
    }
    
     
    private func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
        
}

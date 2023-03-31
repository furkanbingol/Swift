//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by Furkan Bingöl on 29.03.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var emailTextField: UITextField! {
        willSet {
            newValue.autocorrectionType = .no
            newValue.autocapitalizationType = .none
            newValue.autocorrectionType = .no
            newValue.keyboardType = .emailAddress
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        willSet {
            newValue.isSecureTextEntry = true
            newValue.autocorrectionType = .no
            newValue.autocapitalizationType = .none
            newValue.autocorrectionType = .no
        }
    }
    
    
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BU KODU "SceneDelegate" içinde düzenlememiz lazım. Initial View Controlleri değiştirmemiz lazım, eğer kullanıcı daha önceden zaten giriş yaptıysa, uygulama tekrar açıldığında giriş yapılı olmalı.
//        let currentUser = Auth.auth().currentUser
//
//        if currentUser != nil {
//            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
//        }
    }
    
    
    // MARK: - Functions
    
    
    // MARK: - Actions
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let emailText = emailTextField.text, !emailText.isEmpty,
              let passwordText = passwordTextField.text, !passwordText.isEmpty else {
            self.makeAlert(title: "Error", message: "Email or Password field is empty")
            return
        }
        
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { result, error in
            guard let result = result, error == nil else {
                self.makeAlert(title: "Error", message: error!.localizedDescription)
                return
            }
            
            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
        }
        
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let emailText = emailTextField.text,
            let passwordText = passwordTextField.text,
              !emailText.isEmpty, !passwordText.isEmpty else {
            // Eksik field varsa, Alert gösterme
            makeAlert(title: "Error", message: "Email or Password field is empty")
            return
        }
        
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { result, error in
            guard let result = result, error == nil else {
                self.makeAlert(title: "Error", message: error!.localizedDescription)
                return
            }
            
            // Email verification için
//            Auth.auth().currentUser?.sendEmailVerification { error in
//                guard error == nil else { return }
//            }
            
            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
        }
        
    }
    
    
    private func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}


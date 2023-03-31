//
//  ViewController.swift
//  FirebaseLoginScreen
//
//  Created by Furkan Bingöl on 28.03.2023.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailField: UITextField! {
        willSet {
            newValue.autocorrectionType = .no
            newValue.autocapitalizationType = .none
            newValue.spellCheckingType = .no
            newValue.backgroundColor = .white
        }
    }
    @IBOutlet weak var passwordField: UITextField! {
        willSet {
            newValue.isSecureTextEntry = true
            newValue.backgroundColor = .white
        }
    }
    @IBOutlet weak var signInButton: UIButton!  // IBOutlet'le verdiğim instance'lar, initialize edilmiştir!
    
    private var signOutButton: UIButton! {      // Daha oluşmadı, viewDidLoad'da veya herhangi bir yerde initialize etmeliyim!
        willSet {
            newValue.backgroundColor = .systemRed
            newValue.setTitleColor(.white, for: .normal)
            newValue.setTitle("Sign Out", for: .normal)
        }
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            loginLabel.isHidden = true
            emailField.isHidden = true
            passwordField.isHidden = true
            signInButton.isHidden = true
            
            signOutButton = UIButton()
            view.addSubview(signOutButton)
            signOutButton.frame = CGRect(x: 20, y: 150, width: view.frame.size.width - 40, height: 52)
            
            signOutButton.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
        }
        // eğer kullanıcı signIn yapmadıysa zaten tüm ui elementleri gözükecek.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if FirebaseAuth.Auth.auth().currentUser == nil {
            emailField.becomeFirstResponder()
        }
        // Ekran gözüktüğünde emailField kısmı 'ilk respond isteyen kısım' olacak.
        // Klavye açılacak emailField kısmında.
    }
    

    // MARK: - Functions
    @IBAction func didTapButton(_ sender: UIButton) {    // didTap SignIn Button
        
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            // Boş bırakamazsınız alert'i verebiliriz.
            print("Missing field data")
            return
        }
        
        // --- WORKFLOW ---
        // Get auth instance
        // attempt sign in
        // if failure, present ALERT to create account
        // if user continues, create account
        
        // check sign in on app launch
        // allow user to sign out with button
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            // closure içinde self referansını zayıf bir referansa dönüştürdük -> [weak self]
            // Bu nedenle, closure'ın kullanıldığı süre boyunca ViewController sınıfı zayıf bir referans olarak tutulur ve hafıza sızıntısı-memory leak- riski ortadan kalkar.
            
            guard let strongSelf = self else { return }
            guard error == nil else {
                // Show account creation alert! Because user didn't sign in.
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            
            print("You have signed in")
            strongSelf.loginLabel.isHidden = true
            strongSelf.emailField.isHidden = true
            strongSelf.passwordField.isHidden = true
            strongSelf.signInButton.isHidden = true
            strongSelf.emailField.resignFirstResponder()
        }
        
    }
    
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController(title: "Create Account",
                                      message: "Would you like to create an account",
                                      preferredStyle: .alert)
        
        // Creating account
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                
                guard let strongSelf = self else { return }
                guard error == nil else {
                    print("Account creation failed")
                    return
                }
                
                print("You have signed in")
                strongSelf.loginLabel.isHidden = true
                strongSelf.emailField.isHidden = true
                strongSelf.passwordField.isHidden = true
                strongSelf.signInButton.isHidden = true
                strongSelf.emailField.resignFirstResponder()
            }
            
        }))
        
        // Cancel
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        present(alert, animated: true)
    }
    
    
    // IF SignOutButton Tapped
    @objc private func signOutTapped() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            loginLabel.isHidden = false
            emailField.isHidden = false
            passwordField.isHidden = false
            signInButton.isHidden = false
            
            signOutButton.removeFromSuperview()
        }
        catch {
            print("An error occured")
        }
        
    }
}


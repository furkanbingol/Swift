//
//  ViewController.swift
//  UIAlertController
//
//  Created by Furkan Bingöl on 22.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var password2Text: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func signupClick(_ sender: Any) {
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        
        if usernameText.text == "" {
            makeAlert(titleInput: "Error!", messageInput: "Please enter an username!", okButton: okButton)
        }
        else if passwordText.text == "" {
            makeAlert(titleInput: "Error!", messageInput: "Please enter an password!", okButton: okButton)
        }
        else if passwordText.text != password2Text.text {
            makeAlert(titleInput: "Error!", messageInput: "Passwords do not match!", okButton: okButton)
        }
        else {
            makeAlert(titleInput: "Success", messageInput: "Sign up successful!", okButton: okButton)
        }
    }
    
    func makeAlert(titleInput : String, messageInput : String, okButton : UIAlertAction) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}


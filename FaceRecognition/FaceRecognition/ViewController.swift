//
//  ViewController.swift
//  FaceRecognition
//
//  Created by Furkan Bingöl on 4.02.2023.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func signInClick(_ sender: Any) {
        
        let authContext = LAContext()
        var error : NSError?
        
        if(authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)) {    //error: NSError , &error: NSErrorPointer
            
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { success, error in
                //Closure
                if(success == true) {  //successful auth
                    
                    DispatchQueue.main.async {    //Kodu sadece "Main Threadinde" çalıştır
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                }
                else {
                    
                    DispatchQueue.main.async {    //Kodu sadece "Main Threadinde" çalıştır
                        self.myLabel.text = "Error!"
                    }
                }
            }
        }
    }
    
}


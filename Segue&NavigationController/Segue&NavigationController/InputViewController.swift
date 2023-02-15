//
//  InputViewController.swift
//  Segue&NavigationController
//
//  Created by Furkan Bingöl on 15.02.2023.
//

import UIKit

class InputViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toViewController" {
            segue.destination.navigationItem.title = textField.text
        }
    }
}

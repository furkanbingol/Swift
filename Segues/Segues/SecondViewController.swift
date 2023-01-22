//
//  SecondViewController.swift
//  Segues
//
//  Created by Furkan Bingöl on 22.01.2023.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var resultVariable = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = resultVariable
    }
    
    
}

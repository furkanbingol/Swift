//
//  ViewController.swift
//  InterfaceBuilder
//
//  Created by Furkan Bingöl on 10.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let labelFrame = CGRect(x: 90, y: 150, width: 60, height: 25)  //CGRect: struct
        let label = UILabel(frame: labelFrame)
        
        label.text = "Hi"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .blue
        view.addSubview(label)    //O text'i, view'a ekleme
    }


    @IBAction func buttonTapped(_ sender: UIButton) {
        print("button tapped!")
    }
}


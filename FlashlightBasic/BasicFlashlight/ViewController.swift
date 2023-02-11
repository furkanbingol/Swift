//
//  ViewController.swift
//  BasicFlashlight
//
//  Created by Furkan Bingöl on 11.02.2023.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - UI ELEMENTS
    @IBOutlet weak var button: UIButton!
    
    //MARK: - Properties
    var lightOn = true
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    //MARK: - Actions
    @IBAction func buttonTapped(_ sender: Any) {
        lightOn = !lightOn
        updateUI()
    }
    
    //MARK: - Functions
    func updateUI () {
        if(lightOn) {
            view.backgroundColor = .white
            button.setTitle("Turn off", for: UIControl.State.normal)
        } else {
            view.backgroundColor = .black
            button.setTitle("Turn on", for: UIControl.State.normal)
        }
    }
    
}


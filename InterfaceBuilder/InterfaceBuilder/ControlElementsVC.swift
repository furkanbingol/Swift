//
//  ControlElementsVC.swift
//  InterfaceBuilder
//
//  Created by Furkan Bingöl on 12.02.2023.
//

import UIKit

class ControlElementsVC: UIViewController {

    @IBOutlet weak var toggle: UISwitch!
    @IBOutlet weak var slider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    //Button Action
    @IBAction func buttonTapped(_ sender: Any) {               // 'Touch Up Inside' action
        print("button tapped! (in ControlElementsVC)")
        
        if toggle.isOn {
            print("Switch is on!")
        } else {
            print("Switch is off!")
        }
    }
    
    
    //Switch Action
    @IBAction func switchToggled(_ sender: UISwitch) {         // 'Value Changed' action
        if sender.isOn {
            print("The switch is on!")
        } else {
            print("The switch is off!")
        }
    }
    
    
    //Slider Action
    @IBAction func sliderValueChanged(_ sender: UISlider) {    // 'Value Changed' action
        print(sender.value)
    }
    
    
    //Klavyedeki done tuşuna tıklandığında işlenen action ---> 'Primary Action Triggered' action
    @IBAction func keyboardReturnKeyTapped(_ sender: UITextField) {
        if let text = sender.text {
            print(text)
        }
    }
    
    
    //TextField'daki cümle her değiştiğinde tetiklenen action ---> 'Editing Changed' action
    @IBAction func textChanged(_ sender: UITextField) {
        if let text = sender.text {
            print(text)
        }
    }
    
    
    //TapGestureRecognizer'ı Storyboarddan view'a verip, @IBAction ile buradan bağladık
    @IBAction func respondToTapGesture(_ sender: UITapGestureRecognizer) {
        let touch = sender.location(in: view)     //CGPoint bir Struct (x,y değerleri var)
        
        view.endEditing(true)  //KLAVYEYİ KAPATIR
        print(touch)
    }
}

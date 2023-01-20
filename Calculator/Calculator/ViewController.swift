//
//  ViewController.swift
//  Calculator
//
//  Created by Furkan Bingöl on 20.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstText: UITextField!
    @IBOutlet weak var secondText: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    var result = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func sumClick(_ sender: Any) {
        if let firstNumber = Int(firstText.text!){
            if let secondNumber = Int(secondText.text!){
                result = firstNumber + secondNumber
                resultLabel.text = String("Result: " + String(result))
            }
        }
    }
    
    @IBAction func minusClick(_ sender: Any) {
        if let firstNumber = Int(firstText.text!){
            if let secondNumber = Int(secondText.text!){
                result = firstNumber - secondNumber
                resultLabel.text = String("Result: " + String(result))
            }
        }
    }
    
    @IBAction func multiplyClick(_ sender: Any) {
        if let firstNumber = Int(firstText.text!){
            if let secondNumber = Int(secondText.text!){
                result = firstNumber * secondNumber
                resultLabel.text = String("Result: " + String(result))
            }
        }
    }
    
    @IBAction func divideClick(_ sender: Any) {
        if let firstNumber = Int(firstText.text!){
            if let secondNumber = Int(secondText.text!){
                if(secondNumber == 0){
                    resultLabel.text = "Error! You cannot divide by 0"
                }
                else{
                    result = firstNumber / secondNumber
                    resultLabel.text = String("Result: " + String(result))
                }
            }
        }
    }
}


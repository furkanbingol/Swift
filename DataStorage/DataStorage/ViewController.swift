//
//  ViewController.swift
//  DataStorage
//
//  Created by Furkan Bingöl on 21.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var birthdayText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var resultName: UILabel!
    @IBOutlet weak var resultBirthday: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gradient Background
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.red.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)

        
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        //Casting --> as? vs as!
        //as? : Çevirebilirsen çevir
        //as! : KESİN çevirebilirsin   (!: force casting)
        
        if let name = storedName as? String {
            resultName.text = "Your Name: \(name)"
        }
        if let birth = storedBirthday as? String {
            resultBirthday.text = "Your Birthday: \(birth)"
        }
    }

    @IBAction func saveButton(_ sender: Any) {
        //mini database(using UserDefaults class)
        
        UserDefaults.standard.set(nameText.text!, forKey: "name")         //Aynı objeye HER scope'tan erişebilirim
        UserDefaults.standard.set(birthdayText.text!, forKey: "birthday")
        //UserDefaults.synchronize()   //unnecessary
        
        if let name = nameText.text{
            if let birth = birthdayText.text{
                resultName.text = "Your Name: \(name)"
                resultBirthday.text = "Your Birthday: \(birth)"
                /*
                 SAME
                 resultName.text = "Your Name: " + n
                 resultBirthday.text = "Your Birthday: " + b
                */
            }
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        if storedName is String {     //storedName eğer Stringe ise, UserDefaults'tan o kaydı sil
            UserDefaults.standard.removeObject(forKey: "name")
            resultName.text = "Your Name: "
        }
        
        if storedBirthday is String {  //storedBirthday eğer Stringe ise, UserDefaults'tan o kaydı sil
            UserDefaults.standard.removeObject(forKey: "birthday")
            resultBirthday.text = "Your Birthday: "
        }
        
    }
    
}


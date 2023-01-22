//
//  ViewController.swift
//  Segues
//
//  Created by Furkan Bingöl on 22.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var nameText: UITextField!
    
    var variable = ""
    
    //VIEWCONTROLLER LIFECYCLE
    
    //viewDidLoad'tan sonra, ÖNCE viewWillAppear(), SONRA viewDidAppear() çağrılır.
    //Farklı bir ekrana geçtiğimizde ise, ÖNCE viewWillDisappear(), SONRA viewDidDisappear() çağrılır.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad function called")            //1st call - viewDidLoad() yalnızca PROGRAM BASLATILDIGI AN 1 KEZ çalısır.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear function called")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear function called")
        nameText.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {     //3rd call
        print("viewDidAppear function called")
    }
    
    override func viewWillAppear(_ animated: Bool) {    //2nd call
        print("viewWillAppear function called")
    }

    
    
    @IBAction func nextButton(_ sender: Any) {
        variable = nameText.text!
        
        performSegue(withIdentifier: "toSecondVC", sender: nil)
    }
    
    //Segue çağrılmadan ONCE yapılacak işlemler
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toSecondVC"){
            let destinationVC = segue.destination as! SecondViewController   //as: casting
            destinationVC.resultVariable = variable
        }
    }
}


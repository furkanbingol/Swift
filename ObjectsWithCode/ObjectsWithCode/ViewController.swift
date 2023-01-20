//
//  ViewController.swift
//  ObjectsWithCode
//
//  Created by Furkan Bingöl on 20.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var myLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.size.width      //her ekrana göre width alır!
        let height = view.frame.size.height    //her ekrana göre heigth alır!
        
        //UILabel
        myLabel.text = "Test Label"
        myLabel.textAlignment = .center
        myLabel.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.5 - 50/2, width: width * 0.8, height: 50)
        view.addSubview(myLabel)
        
        
        //UIButton
        let myButton = UIButton()
        myButton.setTitle("My Button", for: UIControl.State.normal)
        myButton.setTitleColor(UIColor.brown, for: UIControl.State.normal)
        myButton.frame = CGRect(x: width * 0.5 - 100, y: height * 0.6, width: 200, height: 100)
        view.addSubview(myButton)
        
        //Butona tıklanınca ne olacak?
        myButton.addTarget(self, action: #selector(ViewController.myAction), for: UIControl.Event.touchUpInside)  //self: ViewController'ın kendisi
    }
    
    @objc func myAction() {
        myLabel.text = "Tapped!"
    }

}

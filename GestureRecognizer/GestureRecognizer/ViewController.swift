//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by Furkan Bingöl on 23.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true  //imageView'i, kullanıcı etkileşimine açık yaptık
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changePicture))
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc func changePicture() {
        if(imageView.image == UIImage(named: "apple")){
            imageView.image = UIImage(named: "google")
            infoLabel.text = "Google"
        }
        else{
            imageView.image = UIImage(named: "apple")
            infoLabel.text = "Apple"
        }
    }

}


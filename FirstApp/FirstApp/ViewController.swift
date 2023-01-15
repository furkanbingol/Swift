//
//  ViewController.swift
//  FirstApp
//
//  Created by Furkan Bingöl on 13.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var moviesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    @IBAction func changeClicked(_ sender: Any) {
        if(imageView.image == UIImage(named: "deadpoetssociety")){
            imageView.image = UIImage(named: "matrix")
        }
        else{
            imageView.image = UIImage(named: "deadpoetssociety")
        }
    }
}

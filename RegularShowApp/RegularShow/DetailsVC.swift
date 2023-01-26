//
//  DetailsVC.swift
//  RegularShow
//
//  Created by Furkan Bingöl on 26.01.2023.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
//  var selectedCharacter : RegularShow  --> Error!
    var selectedCharacter : RegularShow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        backgroundImage.alpha = 0.2
        self.view.insertSubview(backgroundImage, at: 0)
        
        nameLabel.text = selectedCharacter?.name
        jobLabel.text = selectedCharacter?.job
        imageView.image = selectedCharacter?.image
    }
    

}

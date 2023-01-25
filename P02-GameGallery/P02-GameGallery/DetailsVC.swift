//
//  DetailsVC.swift
//  P02-GameGallery
//
//  Created by Furkan Bingöl on 25.01.2023.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gameDetail: UITextView!
    
    var selectedGame = ""
    var selectedGameImage = UIImage()
    var selectedGameDetail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg2")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
            
        gameLabel.text = selectedGame
        imageView.image = selectedGameImage
        gameDetail.text = selectedGameDetail
        
    }
    
}

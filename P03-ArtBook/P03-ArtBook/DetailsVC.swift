//
//  DetailsVC.swift
//  P03-ArtBook
//
//  Created by Furkan Bingöl on 27.01.2023.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gRecognizer)  //Tüm view'a UITapGestureRecognizer ekledik
                
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func selectImage() {
        
    }
    

    @IBAction func saveButton(_ sender: Any) {
        
    }
    
}

//
//  DetailsVC.swift
//  P03-ArtBook
//
//  Created by Furkan Bingöl on 27.01.2023.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Recognizers
        let gRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gRecognizer)      //TUM view'a UITapGestureRecognizer ekledik.
                
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
    }
    
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    //imageView'a tıklandığında, telefonun galerisine atmalı
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    //Görseli seçince ne olsun?
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)    //picker'ı kapatır.
    }
    

    @IBAction func saveButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        //Attributes
        newPainting.setValue(artistText.text!, forKey: "artist")
        newPainting.setValue(nameText.text!, forKey: "name")
        if let year = Int(yearText.text!){      //year: Int
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")    //Swift, kendisi 'Unique UID' koyuyor.
        //görseli data'ya çevirmek:
        let data = imageView.image!.jpegData(compressionQuality: 0.5)   //resmi %50 sıkıştır
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
        } catch {
            print("error")
        }
    }
    
}

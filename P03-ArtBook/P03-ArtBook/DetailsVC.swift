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
    @IBOutlet weak var saveButton: UIButton!
    
    var chosenPainting = ""
    var chosenPaintingId = UUID()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(chosenPainting != ""){       //Var olan veri gösterilecek
            
            saveButton.isHidden = true
            
            //Core Data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            fetchRequest.returnsObjectsAsFaults = false
            
            let idString = chosenPaintingId.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)       //id'si, idString'e(seçilen id) eşit olan id'yi bul.
        
            do {
                let results = try context.fetch(fetchRequest)
                
                if (results.count > 0) {
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String {
                            nameText.text = name
                        }
                        
                        if let artist = result.value(forKey: "artist") as? String {
                            artistText.text = artist
                        }
                        
                        if let year = result.value(forKey: "year") as? Int {
                            yearText.text = String(year)
                        }
                        
                        if let imageData = result.value(forKey: "image") as? Data {  //Kaydettiğimiz image: 'Data' tipinde
                            let image = UIImage(data: imageData)  //imageData'yı(Binary Data), UIImage'a çevirdik.
                            imageView.image = image
                        }
                    }
                }
            } catch {
                print("error!")
            }
        }
        else {   //Yeni veri eklenecek
            saveButton.isHidden = false
            saveButton.isEnabled = false    //resim seçmeden buton enable olmayacak
            nameText.text = ""
            artistText.text = ""
            yearText.text = ""
            
            //Recognizers
            let gRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(gRecognizer)      //TUM view'a UITapGestureRecognizer ekledik.
                    
            imageView.isUserInteractionEnabled = true
            let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
            imageView.addGestureRecognizer(imageTapRecognizer)
        }
        
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
        saveButton.isEnabled = true
        self.dismiss(animated: true)    //picker'ı kapatır.
    }
    

    @IBAction func saveButtonClick(_ sender: Any) {
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
        
        //Yeni veriyi, CoreData'ya kaydetme
        do {
            try context.save()
        } catch {
            print("error")
        }
        
        //Diğer ViewController'a mesaj gönderiyoruz
        NotificationCenter.default.post(name: NSNotification.Name("New data added"), object: nil)
        
        //Bir önceki ViewController'a Geri Dönüş
        self.navigationController?.popViewController(animated: true)
    }
    
}


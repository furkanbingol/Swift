//
//  UploadViewController.swift
//  InstaCloneFirebase
//
//  Created by Furkan Bingöl on 29.03.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let storage = Storage.storage().reference()
    let firestoreDatabase = Firestore.firestore()

    
    // MARK: - UI Elements
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextField! {
        willSet {
            newValue.autocorrectionType = .no
            newValue.autocapitalizationType = .none
            newValue.autocorrectionType = .no
        }
    }
    @IBOutlet weak var uploadButton: UIButton!
    
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Resmi tıklanabilir hale getirme ve GestureRecognizer ekleme
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    // MARK: - Functions
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        
        present(pickerController, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // info: Dictionary
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        // Kullanıcı photoLibrary veya camera'yı ilk kez açtığında izin gerekiyor. Bu izni Info.plist'ten veriyoruz.
        // Info.plist --> Privacy - Photo Library Usage Description

        imageView.image = image
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
    // MARK: - Actions
    @IBAction func uploadButtonTapped(_ sender: UIButton) {
        let mediaFolder = storage.child("media")
        
        guard let imageData = imageView.image?.jpegData(compressionQuality: 1) else {
            return
        }
        
        let uuid = UUID().uuidString
        let imageReference = mediaFolder.child("\(uuid).jpg")
        
        imageReference.putData(imageData) { metadata, error in
            guard error == nil else {
                self.makeAlert(title: "Error!", message: error!.localizedDescription)
                return
            }
            
            // O image'in metadatasını(URL'ini) saklamalıyız. --> .downloadURL
            imageReference.downloadURL { url, error in
                guard let url = url, error == nil else {
                    return
                }
                
                let imageUrl = url.absoluteString
                
                
                // DATABASE
                let post = ["imageUrl": imageUrl,
                            "postedBy": Auth.auth().currentUser!.email!,    // Auth.auth().currentUser!.uid 'de olabilir
                            "postComment": self.commentField.text!,
                            "date": FieldValue.serverTimestamp(),           // Date'leri böyle kaydedebiliriz
                            "likes": 0] as [String : Any]
                
                var firestoreRef = self.firestoreDatabase.collection("Posts").addDocument(data: post) { error in
                    guard error == nil else {
                        self.makeAlert(title: "Error", message: error!.localizedDescription)
                        return
                    }
                    
                    // Hata yoksa, veriler veritabanına kaydedilmiştir. Default duruma geri dönmeliyiz ve sayfayı 0.index'e, yani FeedVC'ye geri döndürmeliyiz.
                    self.commentField.text = ""
                    self.imageView.image = UIImage(named: "select-image")
                    self.tabBarController?.selectedIndex = 0
                }
            }
        }
        
        
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

}

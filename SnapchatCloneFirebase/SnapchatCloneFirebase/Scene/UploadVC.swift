//
//  UploadVC.swift
//  SnapchatCloneFirebase
//
//  Created by Furkan Bingöl on 15.07.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

final class UploadVC: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var imageView: UIImageView! {
        willSet {
            newValue.layer.cornerRadius = 10
            newValue.contentMode = .scaleAspectFill
            newValue.isUserInteractionEnabled = true
            
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
            newValue.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    
    // MARK: - Properties
    let firestore = Firestore.firestore()
    let storage = Storage.storage()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Functions
    @IBAction func uploadTapped(_ sender: UIButton) {
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("Media")
        
        // Put data to Storage
        if let data = imageView.image?.jpegData(compressionQuality: 0.9) {
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpg")
            
            imageRef.putData(data) { metadata, error in
                guard let _ = metadata, error == nil else {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
                    return
                }
                
                // Download image url from Storage
                imageRef.downloadURL { url, error in
                    guard let url = url,
                          error == nil
                    else {
                        self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
                        return
                    }
                    
                    // Saving snap infos to Firestore database
                    let imageUrl = url.absoluteString
                    
                    self.firestore.collection("Snaps").whereField("snapOwner", isEqualTo: UserSingleton.shared.username).getDocuments { snapshot, error in
                        guard let snapshot = snapshot,
                              error == nil
                        else {
                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
                            return
                        }
                        
                        // If snapshot is not empty --> current user have been post snap at least one before
                        if snapshot.isEmpty == false {
                            for document in snapshot.documents {
                                let documentId = document.documentID
                                
                                if var imageUrlArray = document.get("imageUrlArray") as? [String] {
                                    imageUrlArray.append(imageUrl)
                                    let newDictionary = ["imageUrlArray": imageUrlArray] as! [String : Any]
                                    
                                    // saving new imageUrlArray to Firestore database
                                    self.firestore.collection("Snaps").document(documentId).setData(newDictionary, merge: true) { error in
                                        guard error == nil else {
                                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
                                            return
                                        }
                                        
                                        self.tabBarController?.selectedIndex = 0
                                        self.imageView.image = UIImage(named: "select-image")
                                    }
                                }
                            }
                        } else {
                            // If snapshot is empty --> current user DOES NOT post any snap before.
                            let snapDictionary = ["imageUrlArray": [imageUrl],
                                                  "snapOwner": UserSingleton.shared.username,
                                                  "date": FieldValue.serverTimestamp()]  as! [String : Any]
                            
                            self.firestore.collection("Snaps").addDocument(data: snapDictionary) { error in
                                guard error == nil else {
                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
                                    return
                                }
                                 
                                self.tabBarController?.selectedIndex = 0
                                self.imageView.image = UIImage(named: "select-image")
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    private func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)

        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc private func imageViewTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        self.present(picker, animated: true)
    }

}

extension UploadVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        imageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true)
    }
}

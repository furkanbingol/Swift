//
//  ViewController.swift
//  FirebasePhotoUploadDownload
//
//  Created by Furkan Bingöl on 28.03.2023.
//

import UIKit
import FirebaseStorage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let storage = Storage.storage().reference()    // Storage Instance
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var downloadUrlLabel: UILabel! {
        willSet {
            newValue.numberOfLines = 0
            newValue.textAlignment = .center
            newValue.contentMode = .scaleAspectFit
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
            let url = URL(string: urlString) else {
            return
        }
        
        downloadUrlLabel.text = urlString
        
        // Downloading image with URLSession
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
                    
            // UI işi olduğu için main threadde yapmalıyız bu işlemi. Closure background threadde çalışıyor.
            DispatchQueue.main.async {
                let image = UIImage(data: data)    // data(binary) --> UIImage
                self.imageView.image = image
            }
        }
        
        task.resume()
    }
    
    @IBAction func didUploadButtonTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    
    // MARK: - UIImagePickerControllerDelegate Functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        // info: Dictionary
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {   // imageData: type of Data(binary)
            return
        }
        
        // Kullanıcı photoLibrary veya camera'yı ilk kez açtığında izin gerekiyor. Bu izni Info.plist'ten veriyoruz.
        // Info.plist --> Privacy - Photo Library Usage Description
        
        // --- UPLOAD image data ---
        // get download url
        // save download url to userDefaults
        
        // example reference --> /Desktop/denemeResim.png
        
        
        storage.child("images/file.png").putData(imageData) { metadata, error in
            guard error == nil else {
                print("Failed to upload to FirebaseStorage")
                return
            }
            
            self.storage.child("images/file.png").downloadURL { url, error in
                guard let url = url, error == nil else {
                    return
                }
                
                let urlString = url.absoluteString
                
                // UI işi olduğu için main threadde yapmalıyız bu işlemi. Closure background threadde çalışıyor.
                DispatchQueue.main.async {
                    self.downloadUrlLabel.text = urlString
                    self.imageView.image = image
                }
                
                
                print("Download URL: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
            }
            
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        
    }
}


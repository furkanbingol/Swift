//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Furkan Bingöl on 25.02.2023.
//

// Frameworks
import UIKit
import SafariServices   //for Safari operations
import MessageUI        //for Mail operations


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {

    // MARK: - UI Elements
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Functions
    
    // Bu fonksiyon, UIImagePicker tarafından bir fotoğraf seçildiğine VEYA çekildiğinde çalışır.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // info: Bir Dictionary'dir ve seçilen&çekilen medya hakkında detaylı bilgi verir.
        // Dictionary içerisinden, kullanıcının seçtiği görsele ulaşılır.
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        // Seçilen görseli imageView'a aktarmak
        imageView.image = selectedImage
        
        // Bir ViewController'ın ekrandan GİTMESİ için kullanılan fonksiyon: dismiss()
        dismiss(animated: true)
    }
    
    
    // MARK: - Actions
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let image = imageView.image else { return }   //ekranda resim olduğundan emin olmak için
        
        // activityItems: paylaşılacak olan nesnelerin dizisi(Any tipinde) (String, Image, Int, URL ...)
        // applicationActivities: Paylaşılacak olan nesnelerin hangi platformlarda paylaşılmasına izin verileceği. (Twitter, Messages, Email ...) (nil -> Default)
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        // present(): Ekranda YENİ BİR CONTROLLER GÖSTERMEK için kullanılır.
        present(activityController, animated: true)      //self.present'te olurdu, aynı şey
    }
    
    
    @IBAction func safariButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "https://apple.com") {
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true)
        }
    }
    
    
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        // iPControllerinin yöneticisi olan sınıfın bu ViewController(self) olduğunu belirtir.
        // Belirtmezsek, delegate fonksiyonları çalışmayacaktır.
        
        
        // --- ALERT OLUŞTURMA ---
        // .actionSheet = Ekranın ALTINDAN gelen sayfa görünümde.
        // .alert = Ekranın ORTASINDA beliren pop-up.
        let alert = UIAlertController(title: "Görsel Kaynağı Seçin", message: nil, preferredStyle: .actionSheet)
        
        // Actionsları oluşturmak
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let cameraAction = UIAlertAction(title: "Kamera", style: .default) { action in     //Closure
            // cameraAction'una tıklandığında bu kod çalışacak.
            
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true)
        }
        let photoLibrary = UIAlertAction(title: "Galeri", style: .default) { action in
            // photoLibrary'ye tıklandığında bu kod çalışacak.
            
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true)
        }
        
        // Oluşturulan actionları UIAlertController'a eklememiz gerek.
        alert.addAction(cancelAction)
        alert.addAction(cameraAction)
        alert.addAction(photoLibrary)
        
        present(alert, animated: true)
    }
    
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        // Öncelikle mail atılabilir bir ortamda olunduğundan emin olmalıyız.
        // Örn: 'Simülatorler' mail ATAMAZ. Bu durumda uygulamanın çökmemesi için bu kontrolü yapmalıyız.
        
        guard !MFMailComposeViewController.canSendMail() else { return }
        /*
         // GUARD İLE AYNI İŞLEM //
        if !MFMailComposeViewController.canSendMail() {
            print("Mail atılamıyor.")
        } else {
            //Yapılacak işlemler...
        }
        */
        
        // Adım 1: Controller oluşturmak
        let mailComposer = MFMailComposeViewController()
        mailComposer.delegate = self
        
        // Mail alıcılarını ayarlayabiliriz.
        mailComposer.setToRecipients(["furkanbingol176@gmail.com", "deneme@icloud.com"])
        
        // Mail'in subjectini ayarlayabiliriz.
        mailComposer.setSubject("Job Application - Furkan Bingol")
        
        // Mail'in içeriğini ayarlayabiliriz.
        mailComposer.setMessageBody("Hello, I am Furkan Bingol. I want to apply for your job posting in the iOS field.", isHTML: false)
        
        // Adım 2: Oluşturulan ViewController'in ekranda gösterilmesi
        present(mailComposer, animated: true)
    }
    
}


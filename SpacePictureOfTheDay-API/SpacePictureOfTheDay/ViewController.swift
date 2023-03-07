//
//  ViewController.swift
//  SpacePictureOfTheDay
//
//  Created by Furkan Bingöl on 7.03.2023.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    
    // MARK: - Properties
    let networkController = NetworkController()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        
        networkController.fetchPhotoInfo { photoInfo in
            guard let photoInfo = photoInfo else { return }
            
            self.updateUI(with: photoInfo)
        }
    }
    
    
    // MARK: - Functions
    
    func updateUI(with photoInfo: PhotoInfo) {
        
        // Arayüz elemanları DAİMA Main Thread'de çalışır.
        // Background Thread'de çalıştırmak için daha farklı bir yol kullanırız.
        
        // --- GCD ---
        // Grand Central Dispatch (GCD), eşzamanlı çalışmayı(CONCURRENCY) yönetmek için kullanılır. GCD, düşük seviyeli bir API'dir.
        // İlk olarak iOS 4'te tanıtıldı. Temel amacı, arka planda ağır görevleri yönetmektir.
        
        networkController.fetchPhoto(from: photoInfo.url) { image in
            guard let image = image else { return }
            
            // Öncelikle main thread'e dönülmesi gerekiyor. Bu işlem GCD fonksiyonları ile mümkün.
            // Main queue'da çalışacak kodlar --> DispatchQueue.main.async { }
            DispatchQueue.main.async {
                self.imageView.image = image
                self.title = photoInfo.title                  // self.title = Navigation Bar'ın title'ı
                self.descriptionLabel.text = photoInfo.description
                if let copyright = photoInfo.copyright {      // copyright: optionaldi?
                    self.copyrightLabel.text = copyright
                } else {
                    self.copyrightLabel.isHidden = true
                }
            }
            
        }
    }
    
    
    // MARK: - Actions
    
    
}


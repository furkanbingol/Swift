//
//  ViewController.swift
//  ViewControllerLifecycle
//
//  Created by Furkan Bingöl on 17.02.2023.
//

import UIKit

class YellowViewController: UIViewController {

    override func viewDidLoad() {     //1st cycle
        super.viewDidLoad()
        
        // Her sayfa için YALNIZCA 1 KEZ ÇALIŞIR.
        // Sayfamız, MEMORYE'ye yüklendikten hemen sonra çalışır.
        // Arayüz elemanlarının ve değişkenlerin kullanıma artık 'hazır' olduğunu belirtir.
        // Yeni arayüz elemanlarını programatic olarak oluşturarak view hiyerarşisine ekleyebileceğimiz bir fonksiyondur.
        // Arayüz elemanlarının özelliklerini güncellemek için uygun bir fonksiyon
        
        print("YellowViewController - viewDidLoad()")
    }
    
    override func viewWillAppear(_ animated: Bool) {      //2nd cycle
        super.viewWillAppear(animated)
        
        // viewDidLoad fonksiyonundan HEMEN SONRA ÇALIŞAN fonksiyon
        // Sayfa her 'ekrana gelmek üzere' olduğu zaman çalışır.
        
        print("YellowViewController - viewWillAppear()")
    }

    override func viewDidAppear(_ animated: Bool) {       //3rd cycle
        super.viewDidAppear(animated)
        
        // viewWillAppear fonksiyonundan hemen sonra çalışan fonksiyon
        // Sayfa her 'ekrana geldikten sonra' çalışır.
        // Animasyon ile çalışıyorsak, animasyonlar bu fonksiyon ile başlatılmalıdır.
        // Uzun bir network request varsa, bu fonksiyon sonrasında başlatılır.
        
        print("YellowViewController - viewDidAppear()")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Sayfa, 'ekrandan gitmek üzere' olduğu zaman çalışır.
        // Örnek: NavigationController'da yeni bir sayfaya push edileceği zaman.
            
        print("YellowViewController - viewWillDisappear()")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // ViewWillDisappear fonksiyonundan sonra tetiklenir.
        // Bir ViewControlller'ın hayat döngüsünde çalışan SON fonksiyondur.
        // Sayfa, 'ekrandan tamamen gittiği' zaman çalışır.
        
        print("YellowViewController - viewDidDisappear()")
    }
}


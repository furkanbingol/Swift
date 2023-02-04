//
//  ViewController.swift
//  DarkMode
//
//  Created by Furkan Bingöl on 4.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var changeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light   //Kullanıcının telefon temasından bağımsız olarak, UserInterfaceStyle'ını daima LIGHT yapabiliriz. Bu satır sadece "O AN Kİ ViewControllerın Temasını" belirler.
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let theme = traitCollection.userInterfaceStyle
        
        if (theme == .dark) {
            changeButton.tintColor = UIColor.white
        }
        else {
            changeButton.tintColor = UIColor.blue
        }
    }
    
    
    //Traitlerden birisi değiştirilirse çalışır (Kullanıcı tema değiştirirse)
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let theme = traitCollection.userInterfaceStyle
        
        if (theme == .dark) {
            changeButton.tintColor = UIColor.white
        }
        else {
            changeButton.tintColor = UIColor.blue
        }
    }

}


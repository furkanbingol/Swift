//
//  ViewController.swift
//  PracticalAnimations
//
//  Created by Furkan Bingöl on 4.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animatableView: UIView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!   // Constraintleri UI-element olarak bağlayabiliriz.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // Ekran gözüktükten sonra çalıştır.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animations
        
        // Closure olduğu için;
        // Main threadde değil, background threadde çalıştığı için aşağıda 'self.' ekledik.
        
        /*
        UIView.animate(withDuration: 1) {    // 3.parametre bir closure.
            self.animatableView.backgroundColor = .blue
            self.animatableView.frame = CGRect(x: 120, y: 400, width: 80, height: 80)
        }
         */
        
        
        /*
         // Diğer bir constructor, 2. parametre(animations) ve 3. parametre(completion) bir closure.
        
         UIView.animate(withDuration: 2) {
            self.animatableView.backgroundColor = .blue
        } completion: { _ in
            // completion kısmı, Animasyon tamamlandıktan sonra çalışıyor.
            UIView.animate(withDuration: 1) {
                self.animatableView.frame = CGRect(x: 120, y: 400, width: 80, height: 80)
            }
        }
         */
        
        /*
        UIView.animate(withDuration: 2, delay: 2, options: [.repeat, .curveEaseIn]) {    // .repeat: bu animasyon sonsuza kadar devam edecek
            self.animatableView.backgroundColor = .blue
            self.animatableView.frame = CGRect(x: 120, y: 400, width: 80, height: 80)
        }
         */
        
        
        //applyScaleTransformation()
        //applyRotationTransformation()
        //applyTranslateTransformation()
        //applyComplexTransform()
        animateWidthConstraintChange()
    }
    
    // Transform: Arayüz elemanları üzerinde; "scale, rotate, translate" gibi değişiklikler
    // yapılmasını sağlayan bir property'dir.
    
    func applyScaleTransformation() {
        let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)   // tam 2 katına scale et.
        
        UIView.animate(withDuration: 2) {
            self.animatableView.transform = scaleTransform
        }
    }
    
    func applyRotationTransformation() {
        let rotationTransform = CGAffineTransform(rotationAngle: (.pi * 7/9))   // .pi = 180 derece
        
        UIView.animate(withDuration: 2) {
            self.animatableView.transform = rotationTransform
        }
    }
    
    func applyTranslateTransformation() {
        let translateTransformation = CGAffineTransform(translationX: 70, y: 200)   // üzerine ne kadar eklenecek x,y olarak
        
        UIView.animate(withDuration: 2) {
            self.animatableView.transform = translateTransformation
        }
    }
    
    
    func applyComplexTransform() {
        let scaleTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        let rotationTransform = CGAffineTransform(rotationAngle: (.pi * 7/9))
        let translateTransformation = CGAffineTransform(translationX: 20, y: 100)
        
        // Animasyonları uç uca birleştirdik --> .concatenating
        let comboTransform = scaleTransform.concatenating(rotationTransform.concatenating(translateTransformation))
        
        /*
        UIView.animate(withDuration: 2) {
            self.animatableView.transform = comboTransform
        }
         */

        UIView.animate(withDuration: 2) {
            self.animatableView.transform = comboTransform
        } completion: { _ in
            sleep(1)
            UIView.animate(withDuration: 1) {
                // Üstteki animasyon bittikten sonra, eski halini geri istiyoruz --> .identity
                self.animatableView.transform = .identity
            }
        }
    }
    
    
    func animateWidthConstraintChange() {
        self.widthConstraint.constant = 300
        
        // view.layoutIfNeeded()
        // Bir önceki durum ile şu an arasındaki CONSTRAINT'lerde bir değişim varsa,
        // constraintleri yeniden hesaplar. (Bu işlem anime edilebilir.)
        
        UIView.animate(withDuration: 2) {
            self.view.layoutIfNeeded()
        }
    }
}


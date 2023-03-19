//
//  FirstViewController.swift
//  UINavigationControllerProgrammatically
//
//  Created by Furkan Bingöl on 17.03.2023.
//

import UIKit

class FirstViewController: UIViewController {

    // MARK: - UI Elements
    private let button = UIButton()
    
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
                    
        button.setTitle("Go to Navigation Controller", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.frame = CGRect(x: view.frame.size.width/2 - 125, y: 100, width: 250, height: 50)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)
    }
    
    
    // MARK: - Functions
    
    @objc private func didTapButton() {
        let rootVC = SecondViewController()
        let navigationVC = UINavigationController(rootViewController: rootVC)
        // UINavigationController: ViewController'ları taşıyan bir STACK ASLINDA.
        // UINavigationController: A container view controller that defines a stack-based scheme for navigating hierarchical content.
        // .push --> Diğer sayfaya geçer.
        // .pop  --> Bir önceki geldiği sayfaya geri döner.
        
        navigationVC.modalPresentationStyle = .fullScreen
        rootVC.title = "Welcome"
        // navigationVC.navigationBar.prefersLargeTitles = true
        
        present(navigationVC, animated: true)     // Ekranda YENİ BİR CONTROLLER GÖSTERMEK için kullanılır.
    }
    
}


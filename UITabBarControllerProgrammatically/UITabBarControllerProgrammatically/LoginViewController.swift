//
//  LoginViewController.swift
//  UITabBarControllerProgrammatically
//
//  Created by Furkan Bingöl on 18.03.2023.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - UI Elements
    private let button: UIButton = {      // Anonymous Closure
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    // Subview'lara LAYOUT verme (viewDidLoad() yüklendikten sonra çalışır!)
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        button.center = view.center
        button.layer.cornerRadius = button.frame.height / 2     // Ovallik için köşeleri kırpar.
    }
    
    // MARK: - Functions
    
    @objc func buttonTapped() {
        // Create and present TabBar Controller
        let tabBarVC = UITabBarController()
        
        // Hepsi ayrı NavigationController. TabBar'da gözükecekler. Bu sayede akış, hepsi için ayrı olacak.
        let vc1 = UINavigationController(rootViewController: FirstViewController())
        let vc2 = UINavigationController(rootViewController: SecondViewController())
        let vc3 = UINavigationController(rootViewController: ThirdViewController())
        let vc4 = UINavigationController(rootViewController: FourthViewController())
        let vc5 = UINavigationController(rootViewController: FifthViewController())
        
        vc1.title = "Home"
        vc2.title = "Contact"
        vc3.title = "Help"
        vc4.title = "About"
        vc5.title = "Settings"
        vc1.navigationBar.prefersLargeTitles = true
        vc2.navigationBar.prefersLargeTitles = true
        vc3.navigationBar.prefersLargeTitles = true
        vc4.navigationBar.prefersLargeTitles = true
        vc5.navigationBar.prefersLargeTitles = true
        
        tabBarVC.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.tabBar.backgroundColor = .lightText
        
        let images = ["house", "bell", "person.circle", "star", "gear"]   // System Images
        
        guard let items = tabBarVC.tabBar.items else { return }
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
            items[x].badgeValue = "\(x + 1)"
        }
        
        present(tabBarVC, animated: true)    // Ekranda farklı ViewController'ları gösterme --> present()
    }
        
}


//
//  SecondViewController.swift
//  UINavigationControllerProgrammatically
//
//  Created by Furkan Bingöl on 17.03.2023.
//

import UIKit

class SecondViewController: UIViewController {

    // MARK: - UI Elements
    private let button = UIButton()
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissSelf))
        
        button.setTitle("Push another controller", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.frame = CGRect(x: view.frame.size.width/2 - 125, y: 100, width: 250, height: 50)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)
    }
    
    
    // MARK: - Functions
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)     // Bir önceki sayfaya döner.
    }
    
    @objc private func didTapButton() {
        let vc = UIViewController()      // random vc, just created for example
        vc.view.backgroundColor = .systemYellow
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

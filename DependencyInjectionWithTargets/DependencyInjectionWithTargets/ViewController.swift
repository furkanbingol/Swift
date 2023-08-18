//
//  ViewController.swift
//  DependencyInjectionWithTargets
//
//  Created by Furkan Bingöl on 18.08.2023.
//

import UIKit
import MyAppUIKit    // TARGET IMPORT
import APIKit        // TARGET IMPORT

extension APICaller: DataFetchable { }

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        button.backgroundColor = .systemBlue
        button.setTitle("Tap Me", for: .normal)
        button.center = view.center
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = button.frame.height / 2.0
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc private func buttonTapped() {
        let dataFetchable: DataFetchable = APICaller.shared
        let vc = CoursesViewController(dataFetchable: dataFetchable)          // Dependency Injection
        present(vc, animated: true)
    }
}


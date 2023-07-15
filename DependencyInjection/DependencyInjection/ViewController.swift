//
//  ViewController.swift
//  DependencyInjection
//
//  Created by Furkan Bingöl on 14.07.2023.
//

import UIKit
import Swinject

class ViewController: UIViewController {
    
    // MARK: - Swinject
    let container: Container = {
        let container = Container()
        
        container.register(BackgroundProviding.self) { resolver in
            return BackgroundProviding()
        }
        container.register(SecondViewController.self) { resolver in
            let vc = SecondViewController(providerProtocol: resolver.resolve(BackgroundProviding.self))
            return vc
        }
        return container
    }()
    

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
        configureButton()
    }
    
    private func configureButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        button.setTitle("Open Another VC", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.center = view.center
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(button)
    }
    
    
    // MARK: - Functions
    @objc private func buttonClicked() {
        if let viewController = container.resolve(SecondViewController.self) {
            present(viewController, animated: true)
        } else {
            print("Resolving Error!")
        }
    }

}


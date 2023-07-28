//
//  RootViewController.swift
//  LoginCasePOP-MVVM
//
//  Created by Furkan Bingöl on 28.07.2023.
//

import UIKit

class RootViewController: UIViewController {

    private let viewModel: RootViewModel
    
    // MARK: - viewModel Injection
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        viewModel.output = self
        viewModel.checkLogin()
    }
    
}

extension RootViewController: RootViewModelOutput {
    func showMainApp() {
        let mainVC = MainViewController()
        DispatchQueue.main.async { sleep(1) }
        
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    func showLogin() {
        let loginVC = LoginViewController()
        DispatchQueue.main.async { sleep(1) }
        
        navigationController?.pushViewController(loginVC, animated: true)
    }
}

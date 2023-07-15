//
//  SecondViewController.swift
//  DependencyInjection
//
//  Created by Furkan Bingöl on 14.07.2023.
//

import UIKit

class SecondViewController: UIViewController {

    private let providerProtocol: BackgroundProvider?
    
    init(providerProtocol: BackgroundProvider?) {
        self.providerProtocol = providerProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = providerProtocol?.backgroundColor ?? .white
    }
    
    
}

//
//  ViewController.swift
//  iOSConcurrency
//
//  Created by Furkan Bingöl on 19.03.2023.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        callBackgroundWork()
    }
    
    
    // MARK: - Functions
    
    func getData() {
        guard let url = URL(string: "example API url") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // ASYNC Bir işlemdir --> URLSesssion.shared.dataTask
            // Background Thread'de çalışır.
            guard let data = data, error == nil else { return }
            
            // self?.view.backgroundColor = .systemRed     // updating UI must be in MAIN QUEUE
            DispatchQueue.main.async {
                self?.view.backgroundColor = .systemRed
            }
        }
        task.resume()
    }
    
    
    func callBackgroundWork() {
        
        DispatchQueue.global(qos: .background).async {
            // do background stuff here
        }
        
    }
    
}


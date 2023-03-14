//
//  ViewController.swift
//  CollectionViewInTableViewCell
//
//  Created by Furkan Bingöl on 13.03.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var models = [Model]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillModel()
        
        tableView.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    // MARK: - Functions
    func fillModel() {
        models.append(Model(text: "First", imageName: "image1"))
        models.append(Model(text: "Third", imageName: "image2"))
        models.append(Model(text: "Second", imageName: "image3"))
        models.append(Model(text: "Demo", imageName: "image4"))
        models.append(Model(text: "First", imageName: "image1"))
        models.append(Model(text: "Third", imageName: "image2"))
        models.append(Model(text: "Second", imageName: "image3"))
        models.append(Model(text: "Demo", imageName: "image4"))
    }
    
    
    // MARK: - TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        
        cell.configure(with: models)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


//
//  FeedVC.swift
//  SnapchatCloneFirebase
//
//  Created by Furkan Bingöl on 15.07.2023.
//

import UIKit

final class FeedVC: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
            newValue.separatorInset.left = 0
            newValue.separatorInset.right = 0
            newValue.showsHorizontalScrollIndicator = false
            newValue.showsVerticalScrollIndicator = false
        }
    }
    
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Functions
    
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

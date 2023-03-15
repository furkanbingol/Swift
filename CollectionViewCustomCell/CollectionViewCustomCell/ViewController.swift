//
//  ViewController.swift
//  CollectionViewCustomCell
//
//  Created by Furkan Bingöl on 15.03.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - UI Elements
    private var collectionView: UICollectionView?
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1            // Satır bazında aradaki boşluğu ayarlar
        layout.minimumInteritemSpacing = 1       // Yanyana olan aralardaki boşluğu ayarlar
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.frame.size.width/3) - 3, height: (view.frame.size.width/3) - 3)
        // Bir satıra 3 tane item sığmasını istiyoruz.  --> /3
        
        
        // Creating a collectionView
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        // Register
        collectionView?.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        // dataSource & delegate
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        // adding a FRAME
        collectionView?.frame = view.bounds
        
        // Add subview to view
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
    
    
    // MARK: - Functions
    
    
    
    // MARK: - CollectionView Functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        
        cell.configure(with: "Custom \(indexPath.row + 1)")     // avoid 0-indexing
        
        return cell
    }
    
    
}


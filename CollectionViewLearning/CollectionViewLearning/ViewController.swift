//
//  ViewController.swift
//  CollectionViewLearning
//
//  Created by Furkan Bingöl on 15.03.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - UI Elements
    private var collectionView: UICollectionView?
    
    // MARK: - Properties
    var imageNames = ["image1","image2","image3","image4","image5","image6"]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.itemSize = CGSize(width: view.frame.size.width/3 - 2, height: view.frame.size.width/3 - 2)
        
        // Creating collectionView
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // Register to cell
        collectionView?.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        
        // delegate & dataSource
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        // Add collectionView to view
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
    
    // MARK: - Functions
    
    override func viewDidLayoutSubviews() {         // collectionView'a FRAME Vermeliyiz
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    
    // MARK: - CollectionView Functions

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count * 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        
        let currentIndex = (indexPath.row % imageNames.count) + 1    // +1 --> 1 indexing
        cell.configure(with: "image\(currentIndex)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("\(indexPath.row).element tapped!")
    }
}


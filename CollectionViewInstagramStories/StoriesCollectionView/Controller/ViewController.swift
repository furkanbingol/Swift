//
//  ViewController.swift
//  StoriesCollectionView
//
//  Created by Furkan Bingöl on 14.03.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - UI Elements
    private var collectionView: UICollectionView?
    
    
    // MARK: - Properties
    var models = [Model]()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillModels()
                
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)      // Padding(Inset)
        
        // Creating CollectionView
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.showsHorizontalScrollIndicator = false
        
        // Register
        collectionView?.register(CircleCollectionViewCell.self, forCellWithReuseIdentifier: CircleCollectionViewCell.identifier)
        
        // Delegate&DataSource
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        // Adding subview to view
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
    
    
    // MARK: - Functions
    
    // Bu fonksiyon Subview'lara 'FRAME' ekler.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 150).integral
        // height = 150 olmasının sebebi, itemSize ile aynı heighti vermek istememiz.
    }
    
    func fillModels() {
        models.append(Model(name: "apple", imageName: "image1"))
        models.append(Model(name: "google", imageName: "image2"))
        models.append(Model(name: "spotify", imageName: "image3"))
        models.append(Model(name: "twitter", imageName: "image4"))
        models.append(Model(name: "apple", imageName: "image1"))
        models.append(Model(name: "google", imageName: "image2"))
        models.append(Model(name: "spotify", imageName: "image3"))
        models.append(Model(name: "twitter", imageName: "image4"))
        models.append(Model(name: "apple", imageName: "image1"))
        models.append(Model(name: "google", imageName: "image2"))
        models.append(Model(name: "spotify", imageName: "image3"))
        models.append(Model(name: "twitter", imageName: "image4"))
    }
    
    
    // MARK: - CollectionView Functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircleCollectionViewCell.identifier, for: indexPath) as! CircleCollectionViewCell
        
        cell.configure(with: models[indexPath.row].imageName)
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 150, height: 150)
//    }
}


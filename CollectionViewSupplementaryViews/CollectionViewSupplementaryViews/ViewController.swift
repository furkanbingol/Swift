//
//  ViewController.swift
//  CollectionViewSupplementaryViews
//
//  Created by Furkan Bingöl on 15.03.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - UI Elements
    private var collectionView: UICollectionView?
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: view.frame.size.width/3 - 3, height: view.frame.size.width/3 - 3)    // /3 -> Her satırda 3 tane item istiyoruz.
        layout.sectionInset = UIEdgeInsets(top: 5, left: 1, bottom: 5, right: 1)
        
        // Creating collectionView
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // Register
        collectionView?.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectionView?.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView?.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier)
        
        // dataSource & delegate
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        // addSubview to view
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
    
    
    // MARK: - Functions
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    
    // MARK: - CollectionView Functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        
        return cell
    }
    
    // Header ve Footer için fonksiyon (SupplementaryViews)
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // Header
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
            
            header.configure(with: false)
            return header
        }
        // Footer
        else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.identifier, for: indexPath) as! FooterCollectionReusableView
            
            footer.configure(with: false)
            return footer
            
        }
    }

    // Header için SIZE belirleme
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 1 {   // 1.sectiondaki headerın size'ı 0 oldu. (Deneme amaçlı)
            return .zero
        }
        
        return CGSize(width: view.frame.size.width, height: view.frame.size.width/1.5)
    }
    
    // Footer için SIZE belirleme
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.width/2)
    }
    
}


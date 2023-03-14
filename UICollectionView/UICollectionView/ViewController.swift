//
//  ViewController.swift
//  UICollectionView
//
//  Created by Furkan Bingöl on 13.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        collectionView.collectionViewLayout = layout
        
        // .register kısmı önemli!
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }


}


// DataSource, Delegate ve DelegateFlowLayout protocollerini ayrı extensionlarda yapmak
// daha OKUNAKLI bir kod dizimi sağlar.

extension ViewController: UICollectionViewDelegate {
    
    // Itemlere tıklandığında çalışacak fonksiyon
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)  // Griliği kaldırır.
        
        print("You tapped me!")
    }
}

extension ViewController: UICollectionViewDataSource {
    
    // Her bir sectionda kaç item var
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    // collectionView'ı çizerken çalışacak fonksiyon.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        
        cell.configure(with: UIImage(named: "image")!)
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // Boyut vermemize olanak sağlar.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
}

//
//  MyCollectionViewCell.swift
//  CollectionViewHeaderFooter
//
//  Created by Furkan Bingöl on 14.03.2023.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .link
    }

}

//
//  MyCollectionViewCell.swift
//  CollectionViewSupplementaryViews
//
//  Created by Furkan Bingöl on 15.03.2023.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyCollectionViewCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemYellow
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

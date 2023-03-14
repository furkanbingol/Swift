//
//  HeaderCollectionReusableView.swift
//  CollectionViewHeaderFooter
//
//  Created by Furkan Bingöl on 14.03.2023.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "HeaderCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    public func configure() {
        backgroundColor = .systemGreen
        
        addSubview(label)
    }
    
    // Subview'lara layout ekleme
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
}

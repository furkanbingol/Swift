//
//  FooterCollectionReusableView.swift
//  CollectionViewHeaderFooter
//
//  Created by Furkan Bingöl on 14.03.2023.
//

import UIKit

class FooterCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "FooterCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "footer"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    public func configure() {
        backgroundColor = .systemRed
        
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}

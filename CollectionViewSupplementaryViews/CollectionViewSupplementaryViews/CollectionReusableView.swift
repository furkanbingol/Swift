//
//  HeaderCollectionReusableView.swift
//  CollectionViewSupplementaryViews
//
//  Created by Furkan Bingöl on 15.03.2023.
//

import UIKit

// Header
class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderCollectionReusableView"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "headerImage"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    // Header init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    // Subviewlara layout ekleme
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    
    // Configure etme fonksiyonu(VC, cell üzerinden bu fonksiyonu çağırabilir)
    public func configure(with showColor: Bool) {
        if showColor {
            imageView.isHidden = true
            backgroundColor = .systemRed
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// Footer
class FooterCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "FooterCollectionReusableView"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "gradientImage"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    // Footer init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    // Subviewlara layout ekleme
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    
    // Configure etme fonksiyonu(VC, cell üzerinden bu fonksiyonu çağırabilir)
    public func configure(with showColor: Bool) {
        if showColor {
            imageView.isHidden = true
            backgroundColor = .systemGreen
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

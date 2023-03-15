//
//  MyCollectionViewCell.swift
//  CollectionViewLearning
//
//  Created by Furkan Bingöl on 15.03.2023.


import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyCollectionViewCell"
    
    private let imageView: UIImageView = {          // Anonymous closure
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // Init of cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    public func configure(with imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

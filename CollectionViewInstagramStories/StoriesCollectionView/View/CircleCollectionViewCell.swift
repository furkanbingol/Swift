//
//  CircleCollectionViewCell.swift
//  StoriesCollectionView
//
//  Created by Furkan Bingöl on 14.03.2023.
//

import UIKit

class CircleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CircleCollectionViewCell"
    
    // 'Anonymous closure' ile oluşturulmuş variable
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        // imageView'ın CIRCULAR olmasını istiyoruz.
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 150/2     // 150 = itemSize |  150/2 = Circle'lık sağlar.
        imageView.backgroundColor = .systemBlue
        imageView.layer.borderWidth = 2        // resmin etrafına border ekler
        imageView.layer.borderColor = UIColor.systemPink.cgColor
        return imageView
    }()
    
    
    // CollectionViewCell'in kendi initi
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)       // view.addSubview() gibi
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    
    public func configure(with imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
    
    
    // Bir hücre yeniden kullanılmadan önce çağrılan bir fonksiyondur ---> prepareForReuse()
    // Bu yöntem, hücrenin yeniden kullanılmadan önce herhangi bir önceki durumunu temizlemesi gerektiğinde kullanılır.
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

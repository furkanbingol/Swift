//
//  CustomCollectionViewCell.swift
//  CollectionViewCustomCell
//
//  Created by Furkan Bingöl on 15.03.2023.
//

import UIKit

/*
imageView üzerindeki;

 .clipsToBounds özelliği true olarak ayarlandığında, UIImageView altındaki alt görünümler (subviews) resim alanının dışına taşıramaz.
 Bu, görüntünün dışına çıkan görünümleri kırpar ve yalnızca UIImageView içinde görüntülenebilecek bölümünü gösterir.
*/

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    
    // MARK: - Properties of cell
    private let imageView: UIImageView = {      // Anonymous Closure
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Custom"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    
    // Init function of cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemYellow
        
        // Adding subviews to CollectionViewCell's content
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.clipsToBounds = true
    }
    
    // Propertylere layout verme fonksiyonu
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width-10, height: contentView.frame.size.height-20)
        label.frame = CGRect(x: 5, y: contentView.frame.size.height-20, width: contentView.frame.size.width-10, height: 20)
        
    }
    
    public func configure(with string: String) {
        label.text = string
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

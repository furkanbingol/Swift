//
//  MyCollectionViewCell.swift
//  CollectionViewInTableViewCell
//
//  Created by Furkan Bingöl on 13.03.2023.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    static let identifer = "MyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    public func configure(with model: Model) {
        myLabel.text = model.text
        myImageView.image = UIImage(named: model.imageName)
    }
}

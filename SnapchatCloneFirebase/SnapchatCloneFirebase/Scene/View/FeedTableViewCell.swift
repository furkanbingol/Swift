//
//  FeedTableViewCell.swift
//  SnapchatCloneFirebase
//
//  Created by Furkan Bingöl on 16.07.2023.
//

import UIKit
import Kingfisher

class FeedTableViewCell: UITableViewCell {

    // MARK: - UI Elements
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var snapImageView: UIImageView! {
        willSet {
            newValue.contentMode = .scaleAspectFit
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(username: String, imageUrl: String) {
        DispatchQueue.main.async {
            self.usernameLabel.text = username
            self.snapImageView.kf.setImage(with: URL(string: imageUrl))
        }
    }

}

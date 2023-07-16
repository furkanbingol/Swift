//
//  FeedTableViewCell.swift
//  SnapchatCloneFirebase
//
//  Created by Furkan Bingöl on 16.07.2023.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    // MARK: - UI Elements
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var snapImageView: UIImageView! {
        willSet {
            newValue.layer.cornerRadius = 8
            // newValue.contentMode = .scaleAspectFill
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(username: String, imageUrl: String) {
        usernameLabel.text = username
        // snapImageView.image
    }

}

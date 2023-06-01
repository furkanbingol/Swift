//
//  SectionTableViewCell.swift
//  ExpandableTableViewCells
//
//  Created by Furkan Bingöl on 25.05.2023.
//

import UIKit

class SectionTableViewCell: UITableViewCell {

    // MARK: - UI Elements
    @IBOutlet weak var label: UILabel!
    
    
    static let identifier = "SectionTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SectionTableViewCell", bundle: nil)
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    
    // MARK: - Functions
    public func configure(with levelText: String) {
        label.text = levelText
    }
    
}

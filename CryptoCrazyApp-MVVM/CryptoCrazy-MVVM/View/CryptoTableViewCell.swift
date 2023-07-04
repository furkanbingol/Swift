//
//  CryptoTableViewCell.swift
//  CryptoCrazy-MVVM
//
//  Created by Furkan Bingöl on 21.06.2023.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    // MARK: - UI Elements
    @IBOutlet weak var currencyText: UILabel!
    @IBOutlet weak var priceText: UILabel!
    
    // MARK: - Properties
    static let identifier = "CryptoCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

}

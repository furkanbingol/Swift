//
//  FeedTableViewCell.swift
//  InstaCloneFirebase
//
//  Created by Furkan Bingöl on 31.03.2023.
//

import UIKit
import Firebase

class FeedTableViewCell: UITableViewCell {
    
    let firestoreDB = Firestore.firestore()

    @IBOutlet weak var userMailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var documentIdLabel: UILabel! {
        willSet {
            newValue.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        guard let documentID = documentIdLabel.text,
              let currentLikeCount = Int(likeLabel.text!) else {
            return
        }
        
        
        let likeStore = ["likes": currentLikeCount + 1] as [String : Any]
        // Tüm dictionary'leri [String : Any] olarak cast etmeliyiz. Firebase tarafı böyle çalışıyor.
        
        // Database'deki VERİYİ GÜNCELLEME
        firestoreDB.collection("Posts").document(documentID).setData(likeStore, merge: true)   // merge: True (Sadece o veriyi güncelle, o documentteki diğer veriler AYNI kalsın)
    
    }
    

}

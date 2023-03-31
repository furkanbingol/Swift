//
//  FeedViewController.swift
//  InstaCloneFirebase
//
//  Created by Furkan Bingöl on 29.03.2023.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let firestoreDB = Firestore.firestore()
    
    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
        }
    }
    
    // MARK: - Properties
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageUrlArray = [String]()
    var documentIdArray = [String]()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromFirestore()
    }
    
    
    // MARK: - Functions
    func getDataFromFirestore() {
        
        // .addSnapshotListener --> Değişiklik olduğu zaman veriyi çekecek ve bizde UI'da göstereceğiz.
        // .order(by: )         --> Verileri nasıl dinlemek istiyoruz: Tarihe göre
        firestoreDB.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot, !snapshot.isEmpty, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            self.userEmailArray.removeAll()
            self.userCommentArray.removeAll()
            self.userImageUrlArray.removeAll()
            self.likeArray.removeAll()
            self.documentIdArray.removeAll()
            
            for document in snapshot.documents {
                let documentID = document.documentID
                self.documentIdArray.append(documentID)
                
                if let postedBy = document.get("postedBy") as? String,
                   let postComment = document.get("postComment") as? String,
                   let likes = document.get("likes") as? Int,
                   let imageUrl = document.get("imageUrl") as? String {
                    self.userEmailArray.append(postedBy)
                    self.userCommentArray.append(postComment)
                    self.likeArray.append(likes)
                    self.userImageUrlArray.append(imageUrl)
                }
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    
    
    // MARK: - TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FeedTableViewCell else {
            return UITableViewCell()
        }
        
        cell.userMailLabel.text = userEmailArray[indexPath.row]
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.likeLabel.text = "\(likeArray[indexPath.row])"
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        
        cell.userImageView.sd_setImage(with: URL(string: userImageUrlArray[indexPath.row]))   // SDWebImage ile Async image download
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Actions
    
    

}

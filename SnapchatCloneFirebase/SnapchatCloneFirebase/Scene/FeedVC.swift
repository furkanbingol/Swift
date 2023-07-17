//
//  FeedVC.swift
//  SnapchatCloneFirebase
//
//  Created by Furkan Bingöl on 15.07.2023.
//

import UIKit
import Firebase

final class FeedVC: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
            newValue.separatorInset.left = 0
            newValue.separatorInset.right = 0
            newValue.showsHorizontalScrollIndicator = false
            newValue.showsVerticalScrollIndicator = true
        }
    }
    
    // MARK: - Properties
    let firestore = Firestore.firestore()
    var snapArray = [Snap]()
    var chosenSnap: Snap?
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
        getSnapsFromFirebase()
    }
    
    
    // MARK: - Functions
    private func getUserInfo() {
        let userEmail = Auth.auth().currentUser!.email!
        
        firestore.collection("UserInfo").whereField("email", isEqualTo: userEmail).getDocuments { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
                return
            }
            
            if snapshot.isEmpty == false {
                for document in snapshot.documents {
                    if let username = document.get("username") as? String {
                        UserSingleton.shared.username = username
                        UserSingleton.shared.email = userEmail
                    }
                }
            }
        }
        
    }
    
    private func getSnapsFromFirebase() {
        // Her değisiklik oldugunda degisimi yansıtacak --> addSnapshotListener
        // .order(by: "date", descending: true)         --> Çekilen snap'leri güncel tarihten eski tarihe olacak şekilde çekiyoruz.
        firestore.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot,
                  error == nil else {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
                return
            }
            
            if snapshot.isEmpty == false {
                self.snapArray.removeAll()
                
                for document in snapshot.documents {
                    guard let snapOwner = document.get("snapOwner") as? String,
                          let imageUrlArray = document.get("imageUrlArray") as? [String],
                          let date = document.get("date") as? Timestamp else {
                        self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
                        return
                    }
                    
                    let documentID = document.documentID
                    
                    if let diffTime = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour {
                        if diffTime >= 24 {
                            // Delete from firebase
                            self.firestore.collection("Snaps").document(documentID).delete()
                        }
                        else {
                            let snap = Snap(username: snapOwner,
                                            imageUrlArray: imageUrlArray,
                                            date: date.dateValue(),
                                            timeDifference: 24 - diffTime)
                            self.snapArray.append(snap)
                        }
                    }
                    
                }
                self.tableView.reloadData()
            }
        }
    }
                
    
    private func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)

        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC" {
            let destVC = segue.destination as! SnapVC
            destVC.selectedSnap = self.chosenSnap
        }
    }
    
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(username: snapArray[indexPath.row].username,
                           imageUrl: snapArray[indexPath.row].imageUrlArray[0])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.chosenSnap = self.snapArray[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
    
}

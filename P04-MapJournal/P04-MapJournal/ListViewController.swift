//
//  ListViewController.swift
//  P04-MapJournal
//
//  Created by Furkan Bingöl on 2.02.2023.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var titleArray = [String]()
    var idArray = [UUID]()
    
    var chosenTitle = ""
    var chosenTitleId = UUID()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClick))
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor(red: CGFloat(39)/255.0, green: CGFloat(60)/255.0, blue: CGFloat(117)/255.0, alpha: 1)

        getData()
    }
    
    @objc func addButtonClick() {
        chosenTitle = ""
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    
    func getData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        fRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fRequest)
            
            if (results.count > 0) {
                titleArray.removeAll()    //duplicate olmasın diye
                idArray.removeAll()
                
                for result in results as! [NSManagedObject] {
                    if let title = result.value(forKey: "title") as? String {
                        titleArray.append(title)
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        idArray.append(id)
                    }
                    tableView.reloadData()
                }
            }
            
        } catch {
            print("error!")
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = titleArray[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80   //cell'ler arası mesafeyi ayarlar
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenTitle = titleArray[indexPath.row]
        chosenTitleId = idArray[indexPath.row]
        tableView.reloadData()
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    //Diğer SEGUE'ye geçmeden önce yapılacaklar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toViewController") {
            let destVC = segue.destination as! ViewController
            destVC.selectedTitle = chosenTitle
            destVC.selectedTitleID = chosenTitleId
        }
    }
}

//
//  ViewController.swift
//  P03-ArtBook
//
//  Created by Furkan Bingöl on 27.01.2023.
//

import UIKit

//CORE DATA: Verileri 'telefon belleğinde' tutan, app silinmediği sürece veriyi SAKLAMAMIZA olanak sağlayan yapı.

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background
        titleImage.image = UIImage(named: "title")
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlusButton))
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor.systemGreen

    }
    
    @objc func addPlusButton() {
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        //content.text = characters[indexPath.row].name
        content.text = "aaa"
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80   //cell'ler arası mesafeyi ayarlar
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.reloadData()
        //performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
    
    
    //Diğer SEGUE'ye geçmeden önce yapılacaklar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDetailsVC"){
            let destVC = segue.destination as! DetailsVC
            //destVC.nameText =
        }
    }
    
}


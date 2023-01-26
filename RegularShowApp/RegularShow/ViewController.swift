//
//  ViewController.swift
//  RegularShow
//
//  Created by Furkan Bingöl on 26.01.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var characters = [RegularShow]()
    var chosenCharacter : RegularShow?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleImage.image = UIImage(named: "rgtitle")
        tableView.delegate = self
        tableView.dataSource = self
        
        //Regular Show Objects
        let mordecai = RegularShow(name: "Mordecai", job: "Groundskeeper", image: UIImage(named: "mordecai")!)
        let rigby = RegularShow(name: "Rigby", job: "Groundskeeper", image: UIImage(named: "rigby")!)
        let benson = RegularShow(name: "Benson Dunwoody", job: "Stick Hockey Master", image: UIImage(named: "benson")!)
        let skips = RegularShow(name: "Skips", job: "Groundskeeper", image: UIImage(named: "skips")!)
        let pops = RegularShow(name: "Pops Maellard - Mega Kranus", job: "Manager", image: UIImage(named: "kranus")!)
        let muscleman = RegularShow(name: "Mitch Sorenstein - Muscle Man", job: "Bodybuilder", image: UIImage(named: "muscleman")!)

        characters.append(mordecai)
        characters.append(rigby)
        characters.append(benson)
        characters.append(skips)
        characters.append(pops)
        characters.append(muscleman)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count   //cell sayısı
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = characters[indexPath.row].name
        content.textProperties.font = UIFont.preferredFont(forTextStyle: .body)
        content.textProperties.font = UIFont.systemFont(ofSize: 19)  //yazı fontunu 19 yapar
        content.textProperties.color = UIColor.darkGray
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110   //cell'ler arası mesafeyi ayarlar
    }
    
    
    //Diğer Segue'ye geçiş
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenCharacter = characters[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    //Diğer Segue'ye GEÇMEDEN ÖNCE yapılacaklar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destVC = segue.destination as! DetailsVC
            destVC.selectedCharacter = chosenCharacter
        }
    }
}


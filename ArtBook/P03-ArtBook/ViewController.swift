//
//  ViewController.swift
//  P03-ArtBook
//
//  Created by Furkan Bingöl on 27.01.2023.
//

import UIKit
import CoreData

//CORE DATA: Verileri 'telefon belleğinde' tutan, app silinmediği sürece veriyi SAKLAMAMIZA olanak sağlayan yapı.
//Core Data, bir nevi 'sqlite veritabanını' kullanıyor.

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    var selectedName = ""
    var selectedId = UUID()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        //Navigasyon Controller'ına rightBarButtonItem ekledik; (+) şeklinde
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlusButton))
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor.brown

        //Veri çekme işlemi - NSFetchRequest
        getData()
    }
    
    //Bu ViewController her gözüktüğünde, işlenecek kod parçası
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("New data added"), object: nil)
        //NotificationCenter'a bir "gözlemci" ekledik. Eğer ("New data added") mesajı görürse, getData() fonksiyonu çağrılacak
    }
    
    
    @objc func addPlusButton() {
        selectedName = ""
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    @objc func getData() {
        
        nameArray.removeAll()  //Duplicate engellemiş olduk
        idArray.removeAll()    //Duplicate engellemiş olduk
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //fetch: getir
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false    //daha hızlı veri çekmeyi sağlamış olur.
        
        do {
            let results = try context.fetch(fetchRequest)   //results, bir array olmuş oldu
            
            if (results.count > 0) {
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        nameArray.append(name)
                    }
                    
                    if let id = result.value(forKey: "id") as? UUID {
                        idArray.append(id)
                    }
                    tableView.reloadData()   //Yeni veri geldi, güncelleme yaptırdık.
                }
            }
            
        } catch {
            print("error!")
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = nameArray[indexPath.row]     //seçim, kaçıncıya denk geliyorsa onu göster
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80   //cell'ler arası mesafeyi ayarlar
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedName = nameArray[indexPath.row]
        selectedId = idArray[indexPath.row]
        tableView.reloadData()
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {    //Silme işlemi gerçekleşirse
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = idArray[indexPath.row].uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if (results.count > 0) {
                    for result in results as! [NSManagedObject] {
                        if let id = result.value(forKey: "id") as? UUID {
                            if (id == idArray[indexPath.row]) {   //Garanti olsun diye
                                context.delete(result)      //O veriyi sil
                                nameArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                tableView.reloadData()
                                
                                do {
                                    try context.save()
                                } catch {
                                    print("error!")
                                }
                                
                                break   //ID unique olduğu için, sildikten sonra döngüyü devam ettirmeye gerek yok
                            }
                        }
                    }
                }
                
            } catch {
                print("error!")
            }
            
        }
    }
    
    
    //Diğer SEGUE'ye geçmeden önce yapılacaklar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDetailsVC"){
            let destVC = segue.destination as! DetailsVC
            destVC.chosenPainting = selectedName
            destVC.chosenPaintingId = selectedId
        }
    }
    
}


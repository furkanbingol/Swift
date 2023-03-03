//
//  SelectRoomTypeTableViewController.swift
//  HotelCalifornia
//
//  Created by Furkan Bingöl on 3.03.2023.
//

import UIKit


protocol SelectRoomTypeTableViewControllerDelegate: class {    // Aslında bir Design Pattern olacak.
    // class: Protokolün yalnızca Class'lar tarafından desteklenebileceğini
    // belirtmek için kullanılır.
    
    func didSelect(roomType: RoomType)
}


class SelectRoomTypeTableViewController: UITableViewController {

    // MARK: - UI Elements
    
    
    // MARK: - Properties
    var selectedRoomType: RoomType?
    weak var delegate: SelectRoomTypeTableViewControllerDelegate?     //strong relation yerine 'weak relation' kurduk class ile (MEMORY MANAGEMENT - ARC)
    // delegate aslında bir önceki sayfanın referansı olacak.
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell")!
        let roomType = RoomType.all[indexPath.row]
        
        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = "$ \(roomType.price)"
        
        if roomType == selectedRoomType {   // 'Equatable' protokolünü conform ettiğimiz için bu kıyaslayamayı yapabiliriz.
            // O an çizilmekte olan oda türü, önceden seçilen oda türü mü?
            cell.accessoryType = .checkmark
            
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedRoomType = RoomType.all[indexPath.row]
        delegate?.didSelect(roomType: selectedRoomType!)   // Bir oda seçildi. Ve sinyal göndereceğiz diğer VC'ye.
        tableView.reloadData()
    }
    
    
    // MARK: - Actions
    
    
}

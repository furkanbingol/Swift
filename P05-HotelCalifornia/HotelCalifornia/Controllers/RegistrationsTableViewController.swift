//
//  RegistrationsTableViewController.swift
//  HotelCalifornia
//
//  Created by Furkan Bingöl on 3.03.2023.
//

import UIKit

class RegistrationsTableViewController: UITableViewController {
    
    // MARK: - UI Elements
    
    
    // MARK: - Properties
    var registrations = [Registration]()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell")!
        let registration = registrations[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = registration.fullName()
        cell.detailTextLabel?.text = dateFormatter.string(from: registration.checkInDate) + " - " +
                                        dateFormatter.string(from: registration.checkOutDate) + ": " +
                                            "\(registration.roomType.name)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Actions
    
    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue) {
        guard let source = unwindSegue.source as? AddRegistrationTableViewController,
              let registration = source.registration else { return }
        
        if registration.firstName != "" && registration.lastName != "" && registration.emailAddress != "" {
            if let firstName = source.registration?.firstName, let lastName = source.registration?.lastName, let email = source.registration?.emailAddress {
                registrations.append(registration)
                tableView.reloadData()
            }
        }
    }
    
}


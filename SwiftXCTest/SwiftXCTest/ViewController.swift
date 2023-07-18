//
//  ViewController.swift
//  SwiftXCTest
//
//  Created by Furkan Bingöl on 18.07.2023.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
            newValue.separatorInset.left = 0
            newValue.separatorInset.right = 0
            newValue.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    // MARK: - Properties
    private var toDoList = [String]()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
    }
    
    
    // MARK: - Functions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Item", message: "Enter Your To Do Item", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter item"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { alertAction in
            guard let textField = alert.textFields?.first,
                  let inputText = textField.text,
                  !inputText.isEmpty else {
                return
            }
            self.toDoList.insert(inputText, at: 0)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}


extension ViewController: UITableViewDelegate { }

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = toDoList[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

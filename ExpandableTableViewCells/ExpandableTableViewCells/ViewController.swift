//
//  ViewController.swift
//  ExpandableTableViewCells
//
//  Created by Furkan Bingöl on 25.05.2023.
//

import UIKit

// Model
class Section {
    let title: String
    let options: [String]
    var isOpened = false
    
    init(title: String, options: [String], isOpened: Bool = false) {
        self.title = title
        self.options = options
        self.isOpened = isOpened
    }
}

// VC
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - UI Elements
    @IBOutlet var tableView: UITableView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
            newValue.register(SectionTableViewCell.nib(), forCellReuseIdentifier: SectionTableViewCell.identifier)
        }
    }
    
    
    // MARK: - Properties
    private var sections = [Section]()
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [
            Section(title: "Section 1", options: [1,2,3].compactMap({ return "Cell \($0)" }) ),
            Section(title: "Section 2", options: [1,2,3].compactMap({ return "Cell \($0)" }) ),
            Section(title: "Section 3", options: [1,2,3].compactMap({ return "Cell \($0)" }) ),
            Section(title: "Section 4", options: [1,2,3].compactMap({ return "Cell \($0)" }) )
        ]
    }
    
    
    // MARK: - Functions
    
    

    // MARK: - TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentSection = sections[section]
        
        if currentSection.isOpened {
            return currentSection.options.count + 1    // optionCells + 1(title cell)
        } else {
            return 1    // title cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionTableViewCell.identifier, for: indexPath) as? SectionTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            cell.configure(with: sections[indexPath.section].title)
            cell.backgroundColor = .systemGroupedBackground
        } else {
            cell.backgroundColor = .white
            cell.configure(with: sections[indexPath.section].options[indexPath.row - 1])     // -1 : because of title cell!
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .none)
        }
    }

}


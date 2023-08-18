//
//  CoursesViewController.swift
//  MyAppUIKit
//
//  Created by Furkan Bingöl on 18.08.2023.
//

import UIKit

public protocol DataFetchable {
    func fetchCourseNames(completion: @escaping ([String]) -> Void)
}

public class CoursesViewController: UIViewController {

    let dataFetchable: DataFetchable
    
    // "Dependency Injection" via Initializer and protocols!
    public init(dataFetchable: DataFetchable) {
        self.dataFetchable = dataFetchable
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private var courseNames = [String]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset.left = 0
        tableView.separatorInset.right = 0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        dataFetchable.fetchCourseNames { resultArray in
            self.courseNames = resultArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
        
}

extension CoursesViewController: UITableViewDelegate { }

extension CoursesViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseNames.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = courseNames[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

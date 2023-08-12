//
//  View.swift
//  CryptoApp-VIPER
//
//  Created by Furkan Bingöl on 12.08.2023.
//

import UIKit

// MARK: - "View" talks to -> Presenter

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func updateView(with cryptos: [Crypto])     // Overloading -> Aynı isimli iki fonksiyon, parametreleri ve işlevleri farklı.
    func updateView(with error: String)
}

final class CryptoViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    var cryptos = [Crypto]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset.left = 0
        tableView.separatorInset.right = 0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        return tableView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        view.backgroundColor = .systemGroupedBackground
    }
    
    override func viewDidLayoutSubviews() {
        // Frame'leri bu fonksiyonda veriyoruz.
        super.viewDidLayoutSubviews()
        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50)
    }
    
    
    // Protocol Functions
    func updateView(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messageLabel.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func updateView(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.tableView.isHidden = true
            self.messageLabel.isHidden = false
            self.messageLabel.text = error
        }
    }
    
}

extension CryptoViewController: UITableViewDelegate { }

extension CryptoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

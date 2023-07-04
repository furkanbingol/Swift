//
//  ViewController.swift
//  CryptoCrazy-MVVM
//
//  Created by Furkan Bingöl on 21.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
            newValue.separatorInset.left = 0
            newValue.separatorInset.right = 0
        }
    }
    
    
    // MARK: - Properties
    private var cryptoListViewModel: CryptoListViewModel!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDatas()
    }
    
    
    // MARK: - Functions
    private func getDatas() {
        NetworkService.shared.downloadCurrencies { cryptos in
            guard let cryptos = cryptos else { return }
            
            self.cryptoListViewModel = CryptoListViewModel(cryptoList: cryptos)
            
            // UI and async operation
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoListViewModel == nil ? 0 : cryptoListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else {
            return UITableViewCell()
        }
        
        let cryptoViewModel = cryptoListViewModel.cryptoAtIndex(indexPath.row)
        cell.currencyText.text = cryptoViewModel.name
        cell.priceText.text = cryptoViewModel.price
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

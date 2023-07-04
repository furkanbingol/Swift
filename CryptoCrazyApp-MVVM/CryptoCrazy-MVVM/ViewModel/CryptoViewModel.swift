//
//  CryptoViewModel.swift
//  CryptoCrazy-MVVM
//
//  Created by Furkan Bingöl on 21.06.2023.
//

import Foundation

struct CryptoViewModel {
    var crypto: CryptoCurrency
    
    // Computed Property (cannot be let!)
    var name: String {
        return crypto.currency
    }
    
    var price: String {
        return crypto.price
    }
}


struct CryptoListViewModel {
    var cryptoList: [CryptoCurrency]
    
    func numberOfRowsInSection() -> Int {
        return self.cryptoList.count
    }
    
    func cryptoAtIndex(_ index: Int) -> CryptoViewModel {
        let crypto = cryptoList[index]
        return CryptoViewModel(crypto: crypto)
    }
}

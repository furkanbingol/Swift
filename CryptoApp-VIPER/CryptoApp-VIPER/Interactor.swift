//
//  Interactor.swift
//  CryptoApp-VIPER
//
//  Created by Furkan Bingöl on 12.08.2023.
//

import UIKit

// MARK: - "Interactor" talks to -> Presenter
// Interactor includes 'business logic'

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func downloadCryptos()
}

final class CryptoInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else {
            self.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.networkFailed))          // Failure
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data,
                  let _ = response,
                  error == nil else {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.networkFailed))     // Failure
                return
            }
            
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))                        // Succes
            } catch {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.parsingFailed))     // Failure
            }
        }
        
        task.resume()
    }
    
}

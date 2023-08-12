//
//  Presenter.swift
//  CryptoApp-VIPER
//
//  Created by Furkan Bingöl on 12.08.2023.
//

import UIKit

// MARK: - "Presenter" talks to Router, Interactor, View

enum NetworkError: Error {
    case networkFailed
    case parsingFailed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidDownloadCrypto(result: Result<[Crypto],Error>)
}

final class CryptoPresenter: AnyPresenter {
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            // Router tarafından değer atanınca(didSet), veri çekme işlemini başlat.
            interactor?.downloadCryptos()
        }
    }
    var view: AnyView?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto],Error>) {
        switch result {
        case .success(let cryptos):
            view?.updateView(with: cryptos)
        case .failure(_):
            view?.updateView(with: "Failed")
        }
    }
}

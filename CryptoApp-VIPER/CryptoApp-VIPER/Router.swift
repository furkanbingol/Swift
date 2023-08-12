//
//  Router.swift
//  CryptoApp-VIPER
//
//  Created by Furkan Bingöl on 12.08.2023.
//

import UIKit

// MARK: - Uygulamanın Entry Point'i, Router'da belirtilecek. Ayrıca Router, diğer yapıların birbirleri ile olan iletişimini sağlar.

typealias EntryPoint = UIViewController & AnyView

protocol AnyRouter {
    var entry: EntryPoint? { get }
    static func startExecution() -> AnyRouter
}

final class CryptoRouter: AnyRouter {
    
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        let router = CryptoRouter()
        
        var view: AnyView = CryptoViewController()
        var presenter: AnyPresenter = CryptoPresenter()
        var interactor: AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    
    
    
}

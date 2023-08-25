//
//  HomeRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol HomeRouterDelegate: AnyRouter {}

class HomeRouter: HomeRouterDelegate {
    
    var entry: EntryPoint?
    
    static func route() -> AnyRouter {
        let router = HomeRouter()
        
        // Assign VIP
        let view = HomeViewController()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        
        // setup view controller with presenter
        view.presenter = presenter
        
        // setup interactor with presenter
        interactor.presenter = presenter
        
        // setup presenter with router, view and interactor
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        // setup router entry with specific view controller
        router.entry = view
        
        return router
    }
    
    func push(to route: Routes, from vc: UIViewController) {}
    
    func pop(from vc: UIViewController) {}
}

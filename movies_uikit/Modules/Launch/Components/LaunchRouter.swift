//
//  LaunchRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol LaunchRouterDelegate: AnyRouter {}

/// - Handles navigation between view controllers
class LaunchRouter: LaunchRouterDelegate {
    
    var entry: EntryPoint?
    
    static func route() -> AnyRouter {
        let router = LaunchRouter()
        
        // Assign VIP
        let view = LaunchViewController()
        let presenter = LaunchPresenter()
        let interactor = LaunchInteractor()
        
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
        
        print("Finished setting up launch route")
        return router
    }
    
    func push(to route: Routes, from vc: UIViewController) {
        vc.navigationController?.pushViewController(route.vc, animated: true)
    }
    
    func pop(from vc: UIViewController) {
        vc.navigationController?.popViewController(animated: true)
    }
}

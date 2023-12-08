//
//  LaunchRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol LaunchRouter: AnyObject {
    var entry: UIViewController? { get }

    static func route() -> LaunchRouter
    
    func navigateToMainTabVC()
}

/// - Handles navigation between view controllers
class LaunchRouterImpl: LaunchRouter {

    var entry: UIViewController?

    static func route() -> LaunchRouter {
        let router = LaunchRouterImpl()

        // Assign VIP
        let view = LaunchViewController()
        let presenter = LaunchPresenterImpl()
        let interactor = LaunchInteractorImpl()

        // setup view controller with presenter
        view.presenter = presenter

        // setup interactor with presenter
        interactor.presenter = presenter

        // setup presenter with router, viewd interactor
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        // setup router entry with specific view controller
        router.entry = view

        return router
    }
    
    func navigateToMainTabVC() {
        entry?.navigationController?.pushViewController(Routes.mainTab.vc, animated: true)
    }
}

//
//  LaunchRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol LaunchRouter: AnyObject, AnyRouter {
    var entry: EntryPoint? { get }

    static func route() -> LaunchRouter
}

/// - Handles navigation between view controllers
class LaunchRouterImpl: LaunchRouter {

    var entry: EntryPoint?

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

        // setup presenter with router, view and interactor
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        // setup router entry with specific view controller
        router.entry = view

        return router
    }

    func push(to route: UIViewController, from vc: UIViewController) {
        vc.navigationController?.pushViewController(route, animated: true)
    }

    func pop(from vc: UIViewController) {
        vc.navigationController?.popViewController(animated: true)
    }
}

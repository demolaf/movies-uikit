//
//  LoginRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import UIKit

protocol LoginRouter: AnyObject, AnyRouter {
    var entry: EntryPoint? { get }

    static func route() -> LoginRouter
}

/// - Handles navigation between view controllers
class LoginRouterImpl: LoginRouter {

    var entry: EntryPoint?

    static func route() -> LoginRouter {
        let router = LoginRouterImpl()

        // Assign VIP
        let view = LoginViewController()
        let presenter = LoginPresenterImpl()
        let interactor = LoginInteractorImpl()

        // setup view controller with presenter
        view.presenter = presenter

        // setup interactor with presenter
        interactor.presenter = presenter
        interactor.authRepository = (UIApplication.shared.delegate as? AppDelegate)?.repositoryProvider.authRepository

        // setup presenter with router, view and interactor
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        // setup router entry with specific view controller
        router.entry = view

        print("Finished setting up login route")
        return router
    }

    func push(to route: UIViewController, from vc: UIViewController) {
        vc.navigationController?.pushViewController(route, animated: true)
    }

    func pop(from vc: UIViewController) {
        vc.navigationController?.popViewController(animated: true)
    }
}

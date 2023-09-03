//
//  LoginRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import UIKit

protocol LoginRouterDelegate: AnyObject {
    var entry: EntryPoint? { get }
}

/// - Handles navigation between view controllers
class LoginRouter: LoginRouterDelegate {

    var entry: EntryPoint?

    static func route() -> LoginRouter {
        let router = LoginRouter()

        // Assign VIP
        let view = LoginViewController()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()

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

    func push(to route: Routes, from vc: UIViewController) {
        vc.navigationController?.pushViewController(route.vc, animated: true)
    }

    func pop(from vc: UIViewController) {
        vc.navigationController?.popViewController(animated: true)
    }
}

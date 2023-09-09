//
//  DetailRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation
import UIKit

protocol DetailRouter: AnyObject, AnyRouter {
    var entry: EntryPoint? { get }

    static func route() -> DetailRouter
}

class DetailRouterImpl: DetailRouter {

    var entry: EntryPoint?

    static func route() -> DetailRouter {
        let router = DetailRouterImpl()

        // Assign VIP
        let view = DetailViewController()
        let presenter = DetailPresenterImpl()
        let interactor = DetailInteractorImpl()

        // setup view controller with presenter
        view.presenter = presenter

        // setup interactor with presenter
        interactor.presenter = presenter
        interactor.userRepository =
        (UIApplication.shared.delegate as? AppDelegate)?
            .repositoryProvider
            .userRepository
        interactor.moviesRepository = (UIApplication.shared.delegate as? AppDelegate)?
            .repositoryProvider
            .moviesRepository

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

    func pop(from vc: UIViewController) {}
}

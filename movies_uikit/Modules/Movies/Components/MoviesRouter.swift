//
//  MoviesRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol MoviesRouterDelegate: AnyObject {
    var entry: EntryPoint? { get }

    func push(to route: UIViewController, from vc: UIViewController)
    func pop(from vc: UIViewController)
}

class MoviesRouter: MoviesRouterDelegate {

    var entry: EntryPoint?

    static func route() -> MoviesRouter {
        let router = MoviesRouter()

        // Assign VIP
        let view = MoviesViewController()
        let presenter = MoviesPresenter()
        let interactor = MoviesInteractor()

        // setup view controller with presenter
        view.presenter = presenter

        // setup interactor with presenter
        interactor.presenter = presenter
        interactor.moviesRepository =
        (UIApplication.shared.delegate as? AppDelegate)?
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

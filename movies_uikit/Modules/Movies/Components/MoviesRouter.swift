//
//  MoviesRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol MoviesRouterDelegate: AnyRouter, AnyObject {}

class MoviesRouter: MoviesRouterDelegate {

    var entry: EntryPoint?

    static func route() -> AnyRouter {
        print("initializing movies route")
        let router = MoviesRouter()

        // Assign VIP
        let view = MoviesViewController()
        let presenter = MoviesPresenter()
        let interactor = MoviesInteractor()

        // setup view controller with presenter
        view.presenter = presenter

        // setup interactor with presenter
        interactor.presenter = presenter
        interactor.moviesRepository = (UIApplication.shared.delegate as? AppDelegate)?.repositoryProvider.moviesRepository

        // setup presenter with router, view and interactor
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        // setup router entry with specific view controller
        router.entry = view
        print("finished initializing movies route")
        return router
    }

    func push(to route: Routes, from vc: UIViewController) {}

    func pop(from vc: UIViewController) {}
}

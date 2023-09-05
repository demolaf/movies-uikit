//
//  TVShowsRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation
import UIKit

protocol TVShowsRouterDelegate: AnyObject {
    var entry: EntryPoint? { get }

    func push(to route: UIViewController, from vc: UIViewController)
    func pop(from vc: UIViewController)
}

class TVShowsRouter: TVShowsRouterDelegate {

    var entry: EntryPoint?

    static func route() -> TVShowsRouter {
        let router = TVShowsRouter()

        // Assign VIP
        let view = TVShowsViewController()
        let presenter = TVShowsPresenter()
        let interactor = TVShowsInteractor()

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

//
//  LibraryRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation
import UIKit

protocol LibraryRouterDelegate: AnyObject {
    var entry: EntryPoint? { get }
}

class LibraryRouter: LibraryRouterDelegate {

    var entry: EntryPoint?

    static func route() -> LibraryRouter {
        print("initializing tvshows route")
        let router = LibraryRouter()

        // Assign VIP
        let view = LibraryViewController()
        let presenter = LibraryPresenter()
        let interactor = LibraryInteractor()

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
        print("finished initializing tvshows route")
        return router
    }

    func push(to route: Routes, from vc: UIViewController) {}

    func pop(from vc: UIViewController) {}
}

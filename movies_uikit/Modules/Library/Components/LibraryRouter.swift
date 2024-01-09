//
//  LibraryRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation
import UIKit

protocol LibraryRouter: AnyObject {
    var entry: UIViewController? { get }

    static func route() -> LibraryRouter
}

class LibraryRouterImpl: LibraryRouter {

    var entry: UIViewController?

    static func route() -> LibraryRouter {
        let router = LibraryRouterImpl()

        // Assign VIP
        let view = LibraryViewController()
        let presenter = LibraryPresenterImpl()
        let interactor = LibraryInteractorImpl()

        // setup view controller with presenter
        view.presenter = presenter

        // setup interactor with presenter
        interactor.presenter = presenter
        interactor.userRepository = RepositoryProvider.shared.userRepository

        // setup presenter with router, view and interactor
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        // setup router entry with specific view controller
        router.entry = view
        return router
    }
}

//
//  MoviesRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol MoviesRouter: AnyObject {
    var entry: UIViewController? { get }

    static func route() -> MoviesRouter

    func navigateToDetailVC(item: Show)

    func navigateToReusableTableVC(sectionTitle: String, items: [Show])
}

class MoviesRouterImpl: MoviesRouter {

    var entry: UIViewController?

    static func route() -> MoviesRouter {
        let router = MoviesRouterImpl()

        // Assign VIP
        let view = MoviesViewController()
        let presenter = MoviesPresenterImpl()
        let interactor = MoviesInteractorImpl()

        // setup view controller with presenter
        view.presenter = presenter

        // setup interactor with presenter
        interactor.presenter = presenter
        interactor.moviesRepository = RepositoryProvider.shared.moviesRepository

        // setup presenter with router, view and interactor
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        // setup router entry with specific view controller
        router.entry = view
        return router
    }

    func navigateToDetailVC(item: Show) {
        guard let detailVC = Routes.detail.vc as? DetailViewController else {
            debugPrint("Failed to navigate to DetailViewController")
            return
        }

        detailVC.hidesBottomBarWhenPushed = true
        detailVC.initializeViewData(show: item)
        entry?.navigationController?.pushViewController(detailVC, animated: true)
    }

    func navigateToReusableTableVC(sectionTitle: String, items: [Show]) {
        let reusableTableVC = ReusableTableViewController()
        reusableTableVC.title = sectionTitle
        reusableTableVC.hidesBottomBarWhenPushed = true
        reusableTableVC.items.accept(items)
        entry?.navigationController?.pushViewController(reusableTableVC, animated: true)
    }
}

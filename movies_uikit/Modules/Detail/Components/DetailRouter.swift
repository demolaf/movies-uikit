//
//  DetailRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation
import UIKit

protocol DetailRouter: AnyObject {
    var entry: UIViewController? { get }

    static func route() -> DetailRouter

    func navigateToDetailVC(item: Show)

    func navigateToReusableTableVC(sectionTitle: String, items: [Show])
}

class DetailRouterImpl: DetailRouter {
    var entry: UIViewController?

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

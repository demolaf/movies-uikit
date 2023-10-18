//
//  TVShowsPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol TVShowsPresenter: AnyObject {
    var view: TVShowsView? { get set }
    var interactor: TVShowsInteractor? { get set }
    var router: TVShowsRouter? { get set }
    var group: DispatchGroup? { get set }

    func initialize()
    func interactorDidFetchPopularTVShows(with tvShows: [TVShow])
    func interactorDidFetchTopRatedTVShows(with tvShows: [TVShow])
    func interactorDidFetchOnTheAirTVShows(with tvShows: [TVShow])

    func tvShowItemTapped(tvShow: TVShow?)
    func viewAllButtonTapped(sectionTitle: String, tvShows: [TVShow])
}

class TVShowsPresenterImpl: TVShowsPresenter {
    var router: TVShowsRouter?
    var interactor: TVShowsInteractor?
    var view: TVShowsView?
    var group: DispatchGroup?

    var popular: [TVShow] = []
    var topRated: [TVShow] = []
    var onTheAir: [TVShow] = []

    func initialize() {
        group = DispatchGroup()
        group?.enter()
        group?.enter()
        group?.enter()

        interactor?.getPopularTVShows()
        interactor?.getTopRatedTVShows()
        interactor?.getOnTheAirTVShows()
    }

    func interactorDidFetchPopularTVShows(with tvShows: [TVShow]) {
        popular = tvShows
    }

    func interactorDidFetchTopRatedTVShows(with tvShows: [TVShow]) {
        topRated = tvShows
    }

    func interactorDidFetchOnTheAirTVShows(with tvShows: [TVShow]) {
        onTheAir = tvShows

        group?.notify(queue: .main) { [self] in
            view?.update(
                popularTVShows: popular,
                topRatedTVShows: topRated,
                onTheAirTVShows: onTheAir
            )
        }
    }

    func tvShowItemTapped(tvShow: TVShow?) {
        let vc = self.view as? TVShowsViewController

        if let vc = vc {
            let detailVC = Routes.detail.vc as? DetailViewController

            if let detailVC = detailVC {
                detailVC.initializeViewData(movie: nil, tvShow: tvShow)
                detailVC.hidesBottomBarWhenPushed = true
                self.router?.push(to: detailVC, from: vc)
            }
        }
    }

    func viewAllButtonTapped(sectionTitle: String, tvShows: [TVShow]) {
        if let vc = view as? TVShowsViewController {
            let reusableTableVC = ReusableTableViewController()
            reusableTableVC.title = sectionTitle
            reusableTableVC.hidesBottomBarWhenPushed = true
            reusableTableVC.items.accept(tvShows)
            router?.push(to: reusableTableVC, from: vc)
        }
    }
}

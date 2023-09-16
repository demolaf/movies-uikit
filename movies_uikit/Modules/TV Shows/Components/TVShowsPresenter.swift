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

    func initialize() {
        interactor?.getPopularTVShows()
        interactor?.getTopRatedTVShows()
        interactor?.getOnTheAirTVShows()
    }

    func interactorDidFetchPopularTVShows(with tvShows: [TVShow]) {
        view?.update(popularTVShows: tvShows)
    }

    func interactorDidFetchTopRatedTVShows(with tvShows: [TVShow]) {
        view?.update(topRatedTVShows: tvShows)
    }

    func interactorDidFetchOnTheAirTVShows(with tvShows: [TVShow]) {
        view?.update(onTheAirTVShows: tvShows)
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

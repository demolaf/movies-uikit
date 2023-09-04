//
//  TVShowsPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol TVShowsPresenterDelegate: AnyObject {
    var view: TVShowsViewDelegate? { get set }
    var interactor: TVShowsInteractorDelegate? { get set }
    var router: TVShowsRouterDelegate? { get set }

    func initialize()
    func interactorDidFetchPopularTVShows(with tvShows: [TVShow])
    func interactorDidFetchTopRatedTVShows(with tvShows: [TVShow])
    func interactorDidFetchOnTheAirTVShows(with tvShows: [TVShow])
}

class TVShowsPresenter: TVShowsPresenterDelegate {
    var router: TVShowsRouterDelegate?
    var interactor: TVShowsInteractorDelegate?
    var view: TVShowsViewDelegate?

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
}

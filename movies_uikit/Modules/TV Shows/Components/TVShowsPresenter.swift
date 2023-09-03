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
    func interactorDidFetchTVShows(with tvShows: [TVShow])
}

class TVShowsPresenter: TVShowsPresenterDelegate {
    var router: TVShowsRouterDelegate?
    var interactor: TVShowsInteractorDelegate?
    var view: TVShowsViewDelegate?

    func initialize() {
        interactor?.getPopularTVShows()
    }

    func interactorDidFetchTVShows(with tvShows: [TVShow]) {
        view?.update(with: tvShows)
    }
}

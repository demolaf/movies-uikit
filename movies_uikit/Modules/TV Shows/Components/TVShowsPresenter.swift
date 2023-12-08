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
    func interactorDidFetchPopularTVShows(with tvShows: [Show])
    func interactorDidFetchTopRatedTVShows(with tvShows: [Show])
    func interactorDidFetchOnTheAirTVShows(with tvShows: [Show])
    func interactorDidFetchSearchResults(with tvShows: [Show])

    func tvShowItemTapped(item: Show)
    func viewAllButtonTapped(sectionTitle: String, items: [Show])

    func searchForTVShow(with query: String)
}

class TVShowsPresenterImpl: TVShowsPresenter {
    var router: TVShowsRouter?
    var interactor: TVShowsInteractor?
    var view: TVShowsView?
    var group: DispatchGroup?

    var popular: [Show] = []
    var topRated: [Show] = []
    var onTheAir: [Show] = []

    func initialize() {
        group = DispatchGroup()

        interactor?.getPopularTVShows()
        interactor?.getTopRatedTVShows()
        interactor?.getOnTheAirTVShows()
    }

    func interactorDidFetchPopularTVShows(with tvShows: [Show]) {
        popular = tvShows
    }

    func interactorDidFetchTopRatedTVShows(with tvShows: [Show]) {
        topRated = tvShows
    }

    func interactorDidFetchOnTheAirTVShows(with tvShows: [Show]) {
        onTheAir = tvShows

        group?.notify(queue: .main) { [self] in
            view?.update(
                popularTVShows: popular,
                topRatedTVShows: topRated,
                onTheAirTVShows: onTheAir
            )
        }
    }

    func tvShowItemTapped(item: Show) {
        router?.navigateToDetailVC(item: item)
    }

    func viewAllButtonTapped(
        sectionTitle: String,
        items: [Show]
    ) {
        router?.navigateToReusableTableVC(sectionTitle: sectionTitle, items: items)
    }

    func searchForTVShow(with query: String) {
        interactor?.searchForTVShow(with: query)
    }

    func interactorDidFetchSearchResults(with tvShows: [Show]) {
        view?.searchResults.onNext(tvShows)
    }
}

//
//  DetailPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol DetailPresenter: AnyObject {
    var view: DetailView? { get set }
    var interactor: DetailInteractor? { get set }
    var router: DetailRouter? { get set }

    func getRecommendedMovies(id: String)
    func bookmarkButtonPressed(show: Show)
    func recommendedItemTapped(item: Show)
    func viewAllButtonTapped(sectionTitle: String, items: [Show])

    func interactorDidFetchRecommendedShows(movies: [Show])
    func interactorDidFetchRecommendedShows(tvShows: [Show])
}

class DetailPresenterImpl: DetailPresenter {

    var router: DetailRouter?

    var interactor: DetailInteractor?

    var view: DetailView?

    // MARK: Presenter Inputs

    func getRecommendedMovies(id: String) {
        interactor?.getRecommendedShows(movie: id)
    }

    func getRecommendedTVShows(id: String) {
        interactor?.getRecommendedShows(tvShow: id)
    }

    func bookmarkButtonPressed(show: Show) {
        // interactor?.bookmarkItem(show: show)
    }

    func fetchRecommendedShowsByShow(id: String) {
        interactor?.getRecommendedShows(movie: id)
    }

    func recommendedItemTapped(item: Show) {
        router?.navigateToDetailVC(item: item)
    }

    func viewAllButtonTapped(sectionTitle: String, items: [Show]) {
        router?.navigateToReusableTableVC(sectionTitle: sectionTitle, items: items)
    }

    // MARK: Presenter Outputs

    func interactorDidFetchRecommendedShows(movies: [Show]) {
        view?.update(recommendedMovies: movies)
    }

    func interactorDidFetchRecommendedShows(tvShows: [Show]) {
        view?.update(recommendedTVShows: tvShows)
    }
}

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
    func getRecommendedTVShows(id: String)
    func bookmarkButtonPressed(movie: Movie)
    func bookmarkButtonPressed(tvShow: TVShow)
    func recommendedItemTapped(item: AnyObject)

    func interactorDidFetchRecommendedShows(movies: [Movie])
    func interactorDidFetchRecommendedShows(tvShows: [TVShow])
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

    func bookmarkButtonPressed(movie: Movie) {
        interactor?.bookmarkItem(movie: movie)
    }

    func bookmarkButtonPressed(tvShow: TVShow) {
        interactor?.bookmarkItem(tvShow: tvShow)
    }

    func fetchRecommendedShowsByShow(id: String) {
        interactor?.getRecommendedShows(movie: id)
    }

    func recommendedItemTapped(item: AnyObject) {
        let detailVC = Routes.detail.vc as? DetailViewController

        if let vc = view as? DetailViewController {
            if let detailVC = detailVC {
                if let item = item as? Movie {
                    detailVC.initializeViewData(movie: item, tvShow: nil)
                }
                if let item = item as? TVShow {
                    detailVC.initializeViewData(movie: nil, tvShow: item)
                }
                detailVC.hidesBottomBarWhenPushed = true
                router?.push(to: detailVC, from: vc)
            }
        }
    }

    // MARK: Presenter Outputs

    func interactorDidFetchRecommendedShows(movies: [Movie]) {
        view?.update(recommendedMovies: movies)
    }

    func interactorDidFetchRecommendedShows(tvShows: [TVShow]) {
        view?.update(recommendedTVShows: tvShows)
    }
}

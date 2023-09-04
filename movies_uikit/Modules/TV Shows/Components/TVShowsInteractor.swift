//
//  TVShowsInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol TVShowsInteractorDelegate: AnyObject {
     var presenter: TVShowsPresenterDelegate? { get set }

     func getPopularTVShows()
     func getTopRatedTVShows()
     func getOnTheAirTVShows()
}

class TVShowsInteractor: TVShowsInteractorDelegate {
    var presenter: TVShowsPresenterDelegate?

    var moviesRepository: MoviesRepository?

    func getPopularTVShows() {
        moviesRepository?.getTVShows(
            categoryType: "popular",
            completion: { [weak self] tvShows in
            debugPrint("TVShows \(tvShows)")
            self?.presenter?.interactorDidFetchPopularTVShows(with: tvShows)
        })
    }

    func getTopRatedTVShows() {
        moviesRepository?.getTVShows(
            categoryType: "top_rated",
            completion: { [weak self] tvShows in
            debugPrint("TVShows \(tvShows)")
            self?.presenter?.interactorDidFetchTopRatedTVShows(with: tvShows)
        })
    }

    func getOnTheAirTVShows() {
        moviesRepository?.getTVShows(
            categoryType: "on_the_air",
            completion: { [weak self] tvShows in
            debugPrint("TVShows \(tvShows)")
            self?.presenter?.interactorDidFetchOnTheAirTVShows(with: tvShows)
        })
    }
}

//
//  TVShowsInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol TVShowsInteractor: AnyObject {
     var presenter: TVShowsPresenter? { get set }

     func getPopularTVShows()
     func getTopRatedTVShows()
     func getOnTheAirTVShows()
}

class TVShowsInteractorImpl: TVShowsInteractor {
    var presenter: TVShowsPresenter?

    var moviesRepository: MoviesRepository?

    func getPopularTVShows() {
        moviesRepository?.getTVShows(
            categoryType: "popular"
        ) { [weak self] tvShows in
            self?.presenter?.interactorDidFetchPopularTVShows(with: tvShows)
        }
    }

    func getTopRatedTVShows() {
        moviesRepository?.getTVShows(
            categoryType: "top_rated"
        ) { [weak self] tvShows in
            self?.presenter?.interactorDidFetchTopRatedTVShows(with: tvShows)
        }
    }

    func getOnTheAirTVShows() {
        moviesRepository?.getTVShows(
            categoryType: "on_the_air"
        ) { [weak self] tvShows in
            self?.presenter?.interactorDidFetchOnTheAirTVShows(with: tvShows)
        }
    }
}

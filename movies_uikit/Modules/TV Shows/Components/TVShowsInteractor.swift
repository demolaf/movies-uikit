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
        presenter?.group?.enter()
        moviesRepository?.getTVShows(
            categoryType: "popular"
        ) { [weak self] tvShows in
            defer {
                self?.presenter?.group?.leave()
            }
            self?.presenter?.interactorDidFetchPopularTVShows(with: tvShows)
        }
    }

    func getTopRatedTVShows() {
        presenter?.group?.enter()
        moviesRepository?.getTVShows(
            categoryType: "top_rated"
        ) { [weak self] tvShows in
            defer {
                self?.presenter?.group?.leave()
            }
            self?.presenter?.interactorDidFetchTopRatedTVShows(with: tvShows)
        }
    }

    func getOnTheAirTVShows() {
        presenter?.group?.enter()
        moviesRepository?.getTVShows(
            categoryType: "on_the_air"
        ) { [weak self] tvShows in
            defer {
                self?.presenter?.group?.leave()
            }
            self?.presenter?.interactorDidFetchOnTheAirTVShows(with: tvShows)
        }
    }
}

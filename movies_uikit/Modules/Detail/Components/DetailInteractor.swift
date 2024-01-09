//
//  DetailInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol DetailInteractor: AnyObject {
    var presenter: DetailPresenter? { get set }

    func bookmarkItem(show: Show)
    func getRecommendedShows(movie id: String)
    func getRecommendedShows(tvShow id: String)
}

class DetailInteractorImpl: DetailInteractor {
    var presenter: DetailPresenter?

    var userRepository: UserRepository?

    var moviesRepository: MoviesRepository?

    func bookmarkItem(show: Show) {
        userRepository?.bookmarkItem(show: show)
    }

    func getRecommendedShows(movie id: String) {
//        moviesRepository?.getRecommendedShowsForMovie(
//            id: id
//        ) { [weak self] movies in
//                self?.presenter?.interactorDidFetchRecommendedShows(movies: movies)
//        }
    }

    func getRecommendedShows(tvShow id: String) {
//        moviesRepository?.getRecommendedShowsForTVShow(
//            id: id
//        ) { [weak self] tvShows in
//                self?.presenter?.interactorDidFetchRecommendedShows(tvShows: tvShows)
//        }
    }
}

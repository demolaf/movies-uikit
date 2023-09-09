//
//  LibraryPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol LibraryPresenter: AnyObject {
    var view: LibraryView? { get set }
    var interactor: LibraryInteractor? { get set }
    var router: LibraryRouter? { get set }

    func initialize()
    func interactorDidFetchBookmarkedMovies(with movies: [Movie])
    func interactorDidFetchBookmarkedTVShows(with tvShows: [TVShow])
}

class LibraryPresenterImpl: LibraryPresenter {
    var router: LibraryRouter?
    var interactor: LibraryInteractor?
    var view: LibraryView?

    func initialize() {
        interactor?.getBookmarkedMovies()
        interactor?.getBookmarkedTVShows()
    }

    func interactorDidFetchBookmarkedMovies(with movies: [Movie]) {
        view?.update(movies: movies)
    }

    func interactorDidFetchBookmarkedTVShows(with tvShows: [TVShow]) {
        view?.update(tvShows: tvShows)
    }
}

//
//  LibraryPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol LibraryPresenterDelegate: AnyObject {
    var view: LibraryViewDelegate? { get set }
    var interactor: LibraryInteractorDelegate? { get set }
    var router: LibraryRouterDelegate? { get set }

    func initialize()
    func interactorDidFetchMovies(with movies: [Movie])
}

class LibraryPresenter: LibraryPresenterDelegate {
    var router: LibraryRouterDelegate?
    var interactor: LibraryInteractorDelegate?
    var view: LibraryViewDelegate?

    func initialize() {
        interactor?.getPopularMovies()
    }

    func interactorDidFetchMovies(with movies: [Movie]) {
        view?.update(with: movies)
    }
}

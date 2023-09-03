//
//  MoviesPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

protocol MoviesPresenterDelegate: AnyObject {
    var view: MoviesViewDelegate? { get set }
    var interactor: MoviesInteractorDelegate? { get set }
    var router: MoviesRouterDelegate? { get set }

    func initialize()
    func interactorDidFetchMovies(with movies: [Movie])
}

class MoviesPresenter: MoviesPresenterDelegate {
    var router: MoviesRouterDelegate?
    var interactor: MoviesInteractorDelegate?
    var view: MoviesViewDelegate?

    func initialize() {
        interactor?.getPopularMovies()
    }

    func interactorDidFetchMovies(with movies: [Movie]) {
        view?.update(with: movies)
    }
}

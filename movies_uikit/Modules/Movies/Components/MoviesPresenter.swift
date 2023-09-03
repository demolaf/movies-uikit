//
//  MoviesPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

protocol MoviesPresenterDelegate: AnyPresenter, AnyObject {
    func interactorDidFetchMovies(with movies: [Movie])
}

class MoviesPresenter: MoviesPresenterDelegate {
    var router: AnyRouter?

    var interactor: AnyInteractor? {
        didSet {
            (interactor as? MoviesInteractor)?.getPopularMovies()
        }
    }

    var view: AnyView?

    func interactorDidFetchMovies(with movies: [Movie]) {
        (view as? MoviesViewController)?.update(with: movies)
    }
}

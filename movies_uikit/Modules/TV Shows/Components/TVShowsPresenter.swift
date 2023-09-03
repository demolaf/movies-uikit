//
//  TVShowsPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol TVShowsPresenterDelegate: AnyPresenter, AnyObject {
    func interactorDidFetchMovies(with movies: [Movie])
}

class TVShowsPresenter: TVShowsPresenterDelegate {
    var router: AnyRouter?

    var interactor: AnyInteractor? {
        didSet {
            (interactor as? TVShowsInteractor)?.getPopularMovies()
        }
    }

    var view: AnyView?

    func interactorDidFetchMovies(with movies: [Movie]) {
        (view as? TVShowsViewController)?.update(with: movies)
    }
}

//
//  DetailPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol DetailPresenterDelegate: AnyPresenter, AnyObject {
    func interactorDidFetchMovies(with movies: [Movie])
}

class DetailPresenter: DetailPresenterDelegate {
    var router: AnyRouter?

    var interactor: AnyInteractor? {
        didSet {
            (interactor as? DetailInteractor)?.getPopularMovies()
        }
    }

    var view: AnyView?

    func interactorDidFetchMovies(with movies: [Movie]) {
        (view as? DetailViewController)?.update(with: movies)
    }
}

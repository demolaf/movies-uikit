//
//  DetailPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol DetailPresenterDelegate: AnyObject {
    var view: DetailViewDelegate? { get set }
    var interactor: DetailInteractorDelegate? { get set }
    var router: DetailRouterDelegate? { get set }

    func initialize()
    func interactorDidFetchMovies(with movies: [Movie])
}

class DetailPresenter: DetailPresenterDelegate {
    var router: DetailRouterDelegate?

    var interactor: DetailInteractorDelegate?

    var view: DetailViewDelegate?

    func initialize() {
        interactor?.getPopularMovies()
    }

    func interactorDidFetchMovies(with movies: [Movie]) {
        view?.update(with: movies)
    }
}

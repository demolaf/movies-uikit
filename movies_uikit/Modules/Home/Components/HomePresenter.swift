//
//  HomePresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

protocol HomePresenterDelegate: AnyPresenter, AnyObject {
    func interactorDidFetchMovies(with movies: [Movie])
}

class HomePresenter: HomePresenterDelegate {
    var router: AnyRouter?

    var interactor: AnyInteractor? {
        didSet {
            (interactor as? HomeInteractor)?.getPopularMovies()
        }
    }

    var view: AnyView?

    func interactorDidFetchMovies(with movies: [Movie]) {
        (view as? HomeViewController)?.update(with: movies)
    }
}

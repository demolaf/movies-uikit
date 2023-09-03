//
//  LibraryPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol LibraryPresenterDelegate: AnyPresenter, AnyObject {
    func interactorDidFetchMovies(with movies: [Movie])
}

class LibraryPresenter: LibraryPresenterDelegate {
    var router: AnyRouter?

    var interactor: AnyInteractor? {
        didSet {
            (interactor as? LibraryInteractor)?.getPopularMovies()
        }
    }

    var view: AnyView?

    func interactorDidFetchMovies(with movies: [Movie]) {
        (view as? LibraryViewController)?.update(with: movies)
    }
}

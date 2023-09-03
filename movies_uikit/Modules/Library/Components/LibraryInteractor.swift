//
//  LibraryInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol LibraryInteractorDelegate: AnyInteractor, AnyObject {
     func getPopularMovies()
}

class LibraryInteractor: LibraryInteractorDelegate {
    var presenter: AnyPresenter?

    var moviesRepository: MoviesRepository?

    func getPopularMovies() {
        moviesRepository?.getPopularMovies(completion: { [weak self] movies in
            debugPrint("Movies \(movies)")
            (self?.presenter as? LibraryPresenter)?.interactorDidFetchMovies(with: movies)
        })
    }
}

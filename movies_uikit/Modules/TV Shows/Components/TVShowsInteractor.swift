//
//  TVShowsInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol TVShowsInteractorDelegate: AnyInteractor, AnyObject {
     func getPopularMovies()
}

class TVShowsInteractor: TVShowsInteractorDelegate {
    var presenter: AnyPresenter?

    var moviesRepository: MoviesRepository?

    func getPopularMovies() {
        moviesRepository?.getPopularMovies(completion: { [weak self] movies in
            debugPrint("Movies \(movies)")
            (self?.presenter as? TVShowsPresenter)?.interactorDidFetchMovies(with: movies)
        })
    }
}

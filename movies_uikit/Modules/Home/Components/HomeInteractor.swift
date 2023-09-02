//
//  HomeInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

protocol HomeInteractorDelegate: AnyInteractor, AnyObject {
     func getPopularMovies()
}

class HomeInteractor: HomeInteractorDelegate {
    var presenter: AnyPresenter?

    var moviesRepository: MoviesRepository?

    func getPopularMovies() {
        moviesRepository?.getPopularMovies(completion: { [weak self] movies in
            debugPrint("Movies \(movies)")
            (self?.presenter as? HomePresenter)?.interactorDidFetchMovies(with: movies)
        })
    }
}

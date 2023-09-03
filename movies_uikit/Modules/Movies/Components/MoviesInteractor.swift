//
//  MoviesInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

protocol MoviesInteractorDelegate: AnyObject {
     var presenter: MoviesPresenterDelegate? { get set }

     func getPopularMovies()
}

class MoviesInteractor: MoviesInteractorDelegate {
    var presenter: MoviesPresenterDelegate?

    var moviesRepository: MoviesRepository?

    func getPopularMovies() {
        moviesRepository?.getPopularMovies(completion: { [weak self] movies in
            debugPrint("Movies \(movies)")
            self?.presenter?.interactorDidFetchMovies(with: movies)
        })
    }
}

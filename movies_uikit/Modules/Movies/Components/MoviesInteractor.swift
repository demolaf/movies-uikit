//
//  MoviesInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

// Interactor usually uses two protocols:
// 1. for actions from the presenter
// 2. for actions from itself
// i.e interactor input and output protocols
protocol MoviesInteractor: AnyObject {
    var presenter: MoviesPresenter? { get set }

    func getMovies()
    func searchForMovie(with query: String)
}

class MoviesInteractorImpl: MoviesInteractor {
    var presenter: MoviesPresenter?

    var moviesRepository: MoviesRepository?

    func getMovies() {
        guard let moviesRepository = moviesRepository else {
            fatalError("MoviesRepository dependency was not provided")
        }
        let popular = moviesRepository.getMovies(categoryType: "popular")
        let new = moviesRepository.getMovies(categoryType: "now_playing")
        let upcoming = moviesRepository.getMovies(categoryType: "top_rated")
        self.presenter?.interactorDidFetchMovies(popular: popular, new: new, upcoming: upcoming)
    }

    func searchForMovie(with query: String) {
//        moviesRepository?.getMovieSearchResults(
//            from: query
//        ) { [weak self] movies in
//            self?.presenter?.interactorDidFetchSearchResults(with: movies)
//        }
    }
}

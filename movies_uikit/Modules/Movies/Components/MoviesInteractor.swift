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

     func getPopularMovies()
     func getNewMovies()
     func getUpcomingMovies()
    func searchForMovie(with query: String)
}

class MoviesInteractorImpl: MoviesInteractor {
    var presenter: MoviesPresenter?

    var moviesRepository: MoviesRepository?

    func getPopularMovies() {
        presenter?.group?.enter()
        moviesRepository?.getMovies(
            categoryType: "popular"
        ) { [weak self] movies in
            defer {
                self?.presenter?.group?.leave()
            }
            self?.presenter?.interactorDidFetchPopularMovies(with: movies)
        }
    }

    func getNewMovies() {
        presenter?.group?.enter()
        moviesRepository?.getMovies(
            categoryType: "now_playing"
        ) { [weak self] movies in
            defer {
                self?.presenter?.group?.leave()
            }
            self?.presenter?.interactorDidFetchNewMovies(with: movies)
        }
    }

    func getUpcomingMovies() {
        presenter?.group?.enter()
        moviesRepository?.getMovies(
            categoryType: "top_rated"
        ) { [weak self] movies in
            defer {
                self?.presenter?.group?.leave()
            }
            self?.presenter?.interactorDidFetchUpcomingMovies(with: movies)
        }
    }

    func searchForMovie(with query: String) {
        moviesRepository?.getMovieSearchResults(
            from: query
        ) { [weak self] movies in
            self?.presenter?.interactorDidFetchSearchResults(with: movies)
        }
    }
}

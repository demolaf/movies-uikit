//
//  MoviesInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

protocol MoviesInteractor: AnyObject {
     var presenter: MoviesPresenter? { get set }

     func getPopularMovies()
     func getNewMovies()
     func getUpcomingMovies()
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
            categoryType: "popular"
        ) { [weak self] movies in
            defer {
                self?.presenter?.group?.leave()
            }
            self?.presenter?.interactorDidFetchUpcomingMovies(with: movies)
        }
    }
}

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
     func getNewMovies()
     func getUpcomingMovies()
}

class MoviesInteractor: MoviesInteractorDelegate {
    var presenter: MoviesPresenterDelegate?

    var moviesRepository: MoviesRepository?

    func getPopularMovies() {
        moviesRepository?.getMovies(
            categoryType: "popular",
            completion: { [weak self] movies in
            debugPrint("Movies \(movies)")
            self?.presenter?.interactorDidFetchPopularMovies(with: movies)
        })
    }

    func getNewMovies() {
        moviesRepository?.getMovies(
            categoryType: "now_playing",
            completion: { [weak self] movies in
            debugPrint("Movies \(movies)")
            self?.presenter?.interactorDidFetchNewMovies(with: movies)
        })
    }

    func getUpcomingMovies() {
        moviesRepository?.getMovies(
            categoryType: "upcoming",
            completion: { [weak self] movies in
            debugPrint("Movies \(movies)")
            self?.presenter?.interactorDidFetchUpcomingMovies(with: movies)
        })
    }
}

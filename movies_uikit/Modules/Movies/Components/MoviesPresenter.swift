//
//  MoviesPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

protocol MoviesPresenterDelegate: AnyObject {
    var view: MoviesViewDelegate? { get set }
    var interactor: MoviesInteractorDelegate? { get set }
    var router: MoviesRouterDelegate? { get set }

    func initialize()
    func interactorDidFetchPopularMovies(with movies: [Movie])
    func interactorDidFetchNewMovies(with movies: [Movie])
    func interactorDidFetchUpcomingMovies(with movies: [Movie])

    func movieItemTapped(movie: Movie?)
}

class MoviesPresenter: MoviesPresenterDelegate {
    var router: MoviesRouterDelegate?
    var interactor: MoviesInteractorDelegate?
    var view: MoviesViewDelegate?

    func initialize() {
        interactor?.getPopularMovies()
        interactor?.getNewMovies()
        interactor?.getUpcomingMovies()
    }

    func interactorDidFetchPopularMovies(with movies: [Movie]) {
        view?.update(popularMovies: movies)
    }

    func interactorDidFetchNewMovies(with movies: [Movie]) {
        view?.update(newMovies: movies)
    }

    func interactorDidFetchUpcomingMovies(with movies: [Movie]) {
        view?.update(upcomingMovies: movies)
    }

    func movieItemTapped(movie: Movie?) {
        let vc = self.view as? MoviesViewController

        if let vc = vc {
            let detailVC = Routes.detail.vc as? DetailViewController

            if let detailVC = detailVC {
                detailVC.initializeViewData(movie: movie, tvShow: nil)
                detailVC.hidesBottomBarWhenPushed = true
                self.router?.push(to: detailVC, from: vc)
            }
        }
    }
}

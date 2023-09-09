//
//  MoviesPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

protocol MoviesPresenter: AnyObject {
    var view: MoviesView? { get set }
    var interactor: MoviesInteractor? { get set }
    var router: MoviesRouter? { get set }

    func initialize()
    func interactorDidFetchPopularMovies(with movies: [Movie])
    func interactorDidFetchNewMovies(with movies: [Movie])
    func interactorDidFetchUpcomingMovies(with movies: [Movie])

    func movieItemTapped(movie: Movie?)
    func viewAllButtonTapped(sectionTitle: String, movies: [Movie])
}

class MoviesPresenterImpl: MoviesPresenter {
    var router: MoviesRouter?
    var interactor: MoviesInteractor?
    var view: MoviesView?

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

    func viewAllButtonTapped(sectionTitle: String, movies: [Movie]) {
        if let vc = view as? MoviesViewController {
            let reusableTableVC = ReusableTableViewController()
            reusableTableVC.title = sectionTitle
            reusableTableVC.hidesBottomBarWhenPushed = true
            reusableTableVC.items = movies
            router?.push(to: reusableTableVC, from: vc)
        }
    }
}

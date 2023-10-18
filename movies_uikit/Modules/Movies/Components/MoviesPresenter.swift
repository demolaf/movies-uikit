//
//  MoviesPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

// Presenter usually uses two protocols:
// 1. for actions from the view
// 2. for actions from the interactor
protocol MoviesPresenter: AnyObject {
    var view: MoviesView? { get set }
    var interactor: MoviesInteractor? { get set }
    var router: MoviesRouter? { get set }
    var group: DispatchGroup? { get set }

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

    var group: DispatchGroup?

    var popular: [Movie] = []
    var new: [Movie] = []
    var upcoming: [Movie] = []

    func initialize() {
        group = DispatchGroup()
        group?.enter()
        group?.enter()
        group?.enter()

        interactor?.getPopularMovies()
        interactor?.getNewMovies()
        interactor?.getUpcomingMovies()
    }

    func interactorDidFetchPopularMovies(with movies: [Movie]) {
        popular = movies
    }

    func interactorDidFetchNewMovies(with movies: [Movie]) {
        new = movies
    }

    func interactorDidFetchUpcomingMovies(with movies: [Movie]) {
        upcoming = movies

        group?.notify(queue: .main) { [self] in
            view?.update(
                popularMovies: popular,
                newMovies: new,
                upcomingMovies: upcoming
            )
        }
    }

    func movieItemTapped(movie: Movie?) {
        if let vc = self.view as? MoviesViewController {
            if let detailVC = Routes.detail.vc as? DetailViewController {
                detailVC.initializeViewData(movie: movie, tvShow: nil)
                detailVC.hidesBottomBarWhenPushed = true
                self.router?.push(to: detailVC, from: vc)
            }
        }
    }

    func viewAllButtonTapped(
        sectionTitle: String,
        movies: [Movie]
    ) {
        if let vc = self.view as? MoviesViewController {
            let reusableTableVC = ReusableTableViewController()
            reusableTableVC.title = sectionTitle
            reusableTableVC.hidesBottomBarWhenPushed = true
            reusableTableVC.items.accept(movies)
            router?.push(to: reusableTableVC, from: vc)
        }
    }
}

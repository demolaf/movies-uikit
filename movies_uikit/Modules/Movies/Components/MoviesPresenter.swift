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
    func interactorDidFetchPopularMovies(with movies: [Show])
    func interactorDidFetchNewMovies(with movies: [Show])
    func interactorDidFetchUpcomingMovies(with movies: [Show])

    func movieItemTapped(item: Show)
    func viewAllButtonTapped(sectionTitle: String, items: [Show])
}

class MoviesPresenterImpl: MoviesPresenter {
    var router: MoviesRouter?
    var interactor: MoviesInteractor?
    var view: MoviesView?

    var group: DispatchGroup?

    var popular: [Show] = []
    var new: [Show] = []
    var upcoming: [Show] = []

    func initialize() {
        group = DispatchGroup()

        interactor?.getPopularMovies()
        interactor?.getNewMovies()
        interactor?.getUpcomingMovies()
    }

    func interactorDidFetchPopularMovies(with movies: [Show]) {
        popular = movies
    }

    func interactorDidFetchNewMovies(with movies: [Show]) {
        new = movies
    }

    func interactorDidFetchUpcomingMovies(with movies: [Show]) {
        upcoming = movies

        group?.notify(queue: .main) { [self] in
            view?.update(
                popularMovies: popular,
                newMovies: new,
                upcomingMovies: upcoming
            )
        }
    }

    func movieItemTapped(item: Show) {
        router?.navigateToDetailVC(item: item)
    }

    func viewAllButtonTapped(
        sectionTitle: String,
        items: [Show]
    ) {
        router?.navigateToReusableTableVC(sectionTitle: sectionTitle, items: items)
    }
}

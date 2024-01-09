//
//  MoviesPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import RxSwift

protocol MoviesPresenter: AnyObject {
    var view: MoviesView? { get set }
    var interactor: MoviesInteractor? { get set }
    var router: MoviesRouter? { get set }

    // Interactor Inputs
    func interactorDidFetchMovies(
        popular: Observable<Result<[Show], APIError>>,
        new: Observable<Result<[Show], APIError>>,
        upcoming: Observable<Result<[Show], APIError>>
    )
    func interactorDidFetchSearchResults(with movies: [Show])

    // View Inputs
    func initialize()
    func movieItemTapped(item: Show)
    func viewAllButtonTapped(sectionTitle: String, items: [Show])
    func searchForMovie(with text: String)
}

class MoviesPresenterImpl: MoviesPresenter {
    var router: MoviesRouter?
    var interactor: MoviesInteractor?
    var view: MoviesView?

    func initialize() {
        interactor?.getMovies()
    }

    func interactorDidFetchMovies(
        popular: Observable<Result<[Show], APIError>>,
        new: Observable<Result<[Show], APIError>>,
        upcoming: Observable<Result<[Show], APIError>>
    ) {
        let fetchedSections = Observable.combineLatest(popular, new, upcoming) { [weak self]
            popular,
            new,
            upcoming -> [MoviesSectionType] in
            guard let self = self else {
                return []
            }
            let popularSection = self.handleFetchingPopularMovies(items: popular)
            let newSection = self.handleFetchingNewMovies(items: new)
            let upcomingSection = self.handleFetchingUpcomingMovies(items: upcoming)
            return [popularSection, newSection, upcomingSection]
        }
        view?.update(fetchedSections: fetchedSections)
    }

    func handleFetchingPopularMovies(items: Result<[Show], APIError>) -> MoviesSectionType {
        switch items {
        case .success(let popular):
            return .carousel(movies: popular)
        case .failure(let error):
            debugPrint("Error fetching popular movies \(error)")
            return .carousel(movies: [])
        }
    }

    func handleFetchingNewMovies(items: Result<[Show], APIError>) -> MoviesSectionType {
        switch items {
        case .success(let new):
            return .topSection(movies: new)
        case .failure(let error):
            debugPrint("Error fetching new movies \(error)")
            return .topSection(movies: [])
        }
    }

    func handleFetchingUpcomingMovies(items: Result<[Show], APIError>) -> MoviesSectionType {
        switch items {
        case .success(let upcoming):
            return .bottomSection(movies: upcoming)
        case .failure(let error):
            debugPrint("Error fetching upcoming movies \(error)")
            return .bottomSection(movies: [])
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

    func searchForMovie(with query: String) {
        interactor?.searchForMovie(with: query)
    }

    func interactorDidFetchSearchResults(with movies: [Show]) {
        view?.searchResults.onNext(movies)
    }
}

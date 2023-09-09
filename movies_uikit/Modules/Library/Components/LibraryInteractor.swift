//
//  LibraryInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol LibraryInteractor: AnyObject {
    var presenter: LibraryPresenter? { get set }

    func getBookmarkedMovies()
    func getBookmarkedTVShows()
}

class LibraryInteractorImpl: LibraryInteractor {
    var presenter: LibraryPresenter?

    var userRepository: UserRepository?

    func getPopularMovies() {}

    func getBookmarkedMovies() {
        userRepository?.getBookmarkedMovies { [weak self] movies in
            debugPrint("items: \(movies)")
            self?.presenter?.interactorDidFetchBookmarkedMovies(with: movies)
        }
    }

    func getBookmarkedTVShows() {
        userRepository?.getBookmarkedTVShows { [weak self] tvShows in
            self?.presenter?.interactorDidFetchBookmarkedTVShows(with: tvShows)
        }
    }
}

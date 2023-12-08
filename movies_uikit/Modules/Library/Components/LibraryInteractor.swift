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
//        if let relay = userRepository?.getBookmarkedMovies() {
//            self.presenter?.interactorDidFetchBookmarkedMovies(with: relay)
//        }
    }

    func getBookmarkedTVShows() {
//        if let relay = userRepository?.getBookmarkedTVShows() {
//            self.presenter?.interactorDidFetchBookmarkedTVShows(with: relay)
//        }
    }
}

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

    func getBookmarkedMovies() {
        if let observable = userRepository?.getBookmarkedMovies() {
            self.presenter?.interactorDidFetchBookmarkedMovies(with: observable)
        }
    }

    func getBookmarkedTVShows() {
        if let observable = userRepository?.getBookmarkedTVShows() {
            self.presenter?.interactorDidFetchBookmarkedTVShows(with: observable)
        }
    }
}

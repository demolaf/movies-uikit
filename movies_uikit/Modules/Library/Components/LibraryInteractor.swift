//
//  LibraryInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol LibraryInteractorDelegate: AnyObject {
     var presenter: LibraryPresenterDelegate? { get set }

     func getPopularMovies()
}

class LibraryInteractor: LibraryInteractorDelegate {
    var presenter: LibraryPresenterDelegate?

    var moviesRepository: MoviesRepository?

    func getPopularMovies() {}
}

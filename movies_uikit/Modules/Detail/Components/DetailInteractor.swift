//
//  DetailInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol DetailInteractorDelegate: AnyObject {
    var presenter: DetailPresenterDelegate? { get set }
}

class DetailInteractor: DetailInteractorDelegate {
    var presenter: DetailPresenterDelegate?

    var moviesRepository: MoviesRepository?
}

//
//  TVShowsInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import Foundation

protocol TVShowsInteractorDelegate: AnyObject {
    var presenter: TVShowsPresenterDelegate? { get set }

     func getPopularTVShows()
}

class TVShowsInteractor: TVShowsInteractorDelegate {
    var presenter: TVShowsPresenterDelegate?

    var moviesRepository: MoviesRepository?

    func getPopularTVShows() {
        moviesRepository?.getPopularTVShows(completion: { [weak self] tvShows in
            debugPrint("TVShows \(tvShows)")
            self?.presenter?.interactorDidFetchTVShows(with: tvShows)
        })
    }
}

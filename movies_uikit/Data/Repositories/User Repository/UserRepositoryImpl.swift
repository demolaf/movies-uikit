//
//  UserRepositoryImpl.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import RxSwift
import RxCocoa

class UserRepositoryImpl: UserRepository {
    let userAPI: UserAPI

    init(userAPI: UserAPI) {
        self.userAPI = userAPI
    }

    func bookmarkItem(show: Show) {
        switch show.type {
        case .movie:
            let movie = show.toMovieDTO()
            userAPI.bookmarkItem(object: movie)
            self.userAPI.bookmarkItem {
                movie.bookmarked = !movie.bookmarked
            }

        case .tv:
            let tvShow = show.toTVShowDTO()
            userAPI.bookmarkItem(object: tvShow)
            self.userAPI.bookmarkItem {
                tvShow.bookmarked = !tvShow.bookmarked
            }
        }
    }

    func getBookmarkedMovies() -> Observable<[Show]> {
        return userAPI.getBookmarkedItems(object: MovieDTO.self).map { movies in
            movies.map { movie in
                movie.toShow()
            }
        }
    }

    func getBookmarkedTVShows() -> Observable<[Show]> {
        return userAPI.getBookmarkedItems(object: TVShowDTO.self).map { tvShows in
            tvShows.map { tvShow in
                tvShow.toShow()
            }
        }
    }
}

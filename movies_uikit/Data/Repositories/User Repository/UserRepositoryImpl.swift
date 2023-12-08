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

    func bookmarkItem(movie: MovieDTO) {
        userAPI.bookmarkItem(object: movie)
        userAPI.bookmarkItem {
            movie.bookmarked = !movie.bookmarked
        }
    }

    func bookmarkItem(tvShow: TVShowDTO) {
        userAPI.bookmarkItem(object: tvShow)
        userAPI.bookmarkItem {
            tvShow.bookmarked = !tvShow.bookmarked
        }
    }

    func getBookmarkedMovies() -> BehaviorRelay<[MovieDTO]> {
        return userAPI.getBookmarkedItems(object: MovieDTO.self)
    }

    func getBookmarkedTVShows() -> BehaviorRelay<[TVShowDTO]> {
        return userAPI.getBookmarkedItems(object: TVShowDTO.self)
    }
}

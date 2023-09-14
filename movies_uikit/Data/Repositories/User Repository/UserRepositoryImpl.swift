//
//  UserRepositoryImpl.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

class UserRepositoryImpl: UserRepository {
    let userAPI: UserAPI

    init(userAPI: UserAPI) {
        self.userAPI = userAPI
    }

    func bookmarkItem(movie: Movie) {
        userAPI.bookmarkItem(object: movie)
        userAPI.bookmarkItem {
            movie.bookmarked = !movie.bookmarked
        }
    }

    func bookmarkItem(tvShow: TVShow) {
        userAPI.bookmarkItem(object: tvShow)
        userAPI.bookmarkItem {
            tvShow.bookmarked = !tvShow.bookmarked
        }
    }

    func getBookmarkedMovies(completion: @escaping ([Movie]) -> Void) {
        userAPI.getBookmarkedItems(object: Movie.self) { items in
            completion(items)
        }
    }

    func getBookmarkedTVShows(completion: @escaping ([TVShow]) -> Void) {
        userAPI.getBookmarkedItems(object: TVShow.self) { items in
            completion(items)
        }
    }
}

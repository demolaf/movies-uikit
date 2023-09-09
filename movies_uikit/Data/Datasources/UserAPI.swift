//
//  UserAPI.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

/// For User saved data such as favorite movies and tv shows
class UserAPI {
    let localStorage: LocalStorage

    init(localStorage: LocalStorage) {
        self.localStorage = localStorage
    }

    // store for library (movies/tv shows) in realm
    func bookmarkItem<T: AnyObject>(object: T) {
        localStorage.update(object: object)
    }

    // get for library (movies/tv shows) from realm
    func getBookmarkedItems<T: AnyObject>(
        object: T.Type,
        completion: @escaping ([T]) -> Void
    ) {
        localStorage.readAll(object: T.self, sortBy: "createdAt") { items, _ in
            completion(items)
        }
    }
}

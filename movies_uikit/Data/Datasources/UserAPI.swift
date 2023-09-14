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

    func bookmarkItem<T: AnyObject>(object: T) {
        localStorage.update(object: object)
    }

    func bookmarkItem(callback: @escaping () -> Void) {
        localStorage.updateProperty(callback: callback)
    }

    func getBookmarkedItems<T: AnyObject>(
        object: T.Type,
        completion: @escaping ([T]) -> Void
    ) {
        localStorage.readAll(
            object: T.self,
            sortBy: "createdAt",
            predicate: NSPredicate(format: "bookmarked == %d", true)
        ) { items, _ in
            completion(items)
        }
    }
}

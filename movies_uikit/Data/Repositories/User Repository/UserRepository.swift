//
//  UserRepository.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

protocol UserRepository {
    func bookmarkItem(show: Show)
    func getBookmarkedMovies() -> Observable<[Show]>
    func getBookmarkedTVShows() -> Observable<[Show]>
}

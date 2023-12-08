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
    func bookmarkItem(movie: MovieDTO)
    func bookmarkItem(tvShow: TVShowDTO)
    func getBookmarkedMovies() -> BehaviorRelay<[MovieDTO]>
    func getBookmarkedTVShows() -> BehaviorRelay<[TVShowDTO]>
}

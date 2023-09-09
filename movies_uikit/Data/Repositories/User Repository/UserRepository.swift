//
//  UserRepository.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import RealmSwift

protocol UserRepository {
    func bookmarkItem(movie: Movie)
    func bookmarkItem(tvShow: TVShow)
    func getBookmarkedMovies(completion: @escaping ([Movie]) -> Void)
    func getBookmarkedTVShows(completion: @escaping ([TVShow]) -> Void)
}

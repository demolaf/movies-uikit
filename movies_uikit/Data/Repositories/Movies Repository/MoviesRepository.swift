//
//  MoviesRepository.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

protocol MoviesRepository {
    func getMovies(categoryType: String, completion: @escaping ([Movie]) -> Void)
    func getTVShows(categoryType: String, completion: @escaping ([TVShow]) -> Void)
}

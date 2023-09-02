//
//  MoviesRepository.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

protocol MoviesRepository {
    func getPopularMovies(completion: @escaping ([Movie]) -> Void)
}

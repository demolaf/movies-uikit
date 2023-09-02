//
//  MoviesRepositoryImpl.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

class MoviesRepositoryImpl: MoviesRepository {
    private let moviesAPI: MoviesAPI

    init(moviesAPI: MoviesAPI) {
        self.moviesAPI = moviesAPI
    }

    func getPopularMovies(completion: @escaping ([Movie]) -> Void) {
        moviesAPI.getPopularMovies { result in
            switch result {
            case .success(let movies):
                completion(movies)
            case .failure(let error):
                debugPrint("Failed to fetch movies \(error)")
                completion([])
            }
        }
    }
}

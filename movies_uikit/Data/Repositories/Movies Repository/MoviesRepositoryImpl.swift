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

    func getMovies(categoryType: String, completion: @escaping ([Movie]) -> Void) {
        moviesAPI.getMovies(
            categoryType: categoryType
        ) { result in
            switch result {
            case .success(let movies):
                completion(movies)
            case .failure(let error):
                debugPrint("Failed to fetch movies \(error)")
                completion([])
            }
        }
    }

    func getTVShows(categoryType: String, completion: @escaping ([TVShow]) -> Void) {
        moviesAPI.getTVShows(
            categoryType: categoryType
        ) { result in
            switch result {
            case .success(let tvShows):
                completion(tvShows)
            case .failure(let error):
                debugPrint("Failed to fetch tvShows \(error)")
                completion([])
            }
        }
    }

    func getRecommendedShowsForMovie(
        id: String,
        completion: @escaping ([Movie]) -> Void
    ) {
        moviesAPI.getRecommendedShowsByMovie(id: id) { result in
            switch result {
            case .success(let movies):
                completion(movies)
            case .failure(let error):
                debugPrint("Failed to fetch recommended movies \(error)")
                completion([])
            }
        }
    }

    func getRecommendedShowsForTVShow(
        id: String,
        completion: @escaping ([TVShow]) -> Void
    ) {
        moviesAPI.getRecommendedShowsByTVShow(id: id) { result in
            switch result {
            case .success(let tvShows):
                completion(tvShows)
            case .failure(let error):
                debugPrint("Failed to fetch recommended tvshows \(error)")
                completion([])
            }
        }
    }
}

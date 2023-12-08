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

    func getMovies(
        categoryType: String,
        completion: @escaping ([Show]) -> Void
    ) {
        moviesAPI.getMovies(
            categoryType: categoryType
        ) { result in
            switch result {
            case .success(let movies):
                let result = movies.map { $0.toShow() }
                completion(result)
            case .failure(let error):
                debugPrint("Failed to fetch movies \(error)")
                completion([])
            }
        }
    }

    func getTVShows(
        categoryType: String,
        completion: @escaping ([Show]) -> Void
    ) {
        moviesAPI.getTVShows(
            categoryType: categoryType
        ) { result in
            switch result {
            case .success(let tvShows):
                let result = tvShows.map { $0.toShow() }
                completion(result)
            case .failure(let error):
                debugPrint("Failed to fetch tvShows \(error)")
                completion([])
            }
        }
    }

    func getRecommendedShowsForMovie(
        id: String,
        completion: @escaping ([Show]) -> Void
    ) {
        moviesAPI.getRecommendedShowsByMovie(id: id) { result in
            switch result {
            case .success(let movies):
                let result = movies.map { $0.toShow() }
                completion(result)
            case .failure(let error):
                debugPrint("Failed to fetch recommended movies \(error)")
                completion([])
            }
        }
    }

    func getRecommendedShowsForTVShow(
        id: String,
        completion: @escaping ([Show]) -> Void
    ) {
        moviesAPI.getRecommendedShowsByTVShow(id: id) { result in
            switch result {
            case .success(let tvShows):
                let result = tvShows.map { $0.toShow() }
                completion(result)
            case .failure(let error):
                debugPrint("Failed to fetch recommended tvshows \(error)")
                completion([])
            }
        }
    }

    func getMovieSearchResults(
        from query: String,
        completion: @escaping ([Show]) -> Void
    ) {
        moviesAPI.getMovieSearchResults(from: query) { result in
            switch result {
            case .success(let movies):
                let result = movies.map { $0.toShow() }
                completion(result)
            case .failure(let error):
                debugPrint("Failed to fetch movie search results \(error)")
                completion([])
            }
        }
    }

    func getTVShowsSearchResults(
        from query: String,
        completion: @escaping ([Show]) -> Void
    ) {
        moviesAPI.getTVShowsSearchResults(from: query) { result in
            switch result {
            case .success(let tvShows):
                let result = tvShows.map { $0.toShow() }
                completion(result)
            case .failure(let error):
                debugPrint("Failed to fetch tv show search results \(error)")
                completion([])
            }
        }
    }
}

//
//  MoviesRepositoryImpl.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import RxSwift

class MoviesRepositoryImpl: MoviesRepository {
    private let moviesAPI: MoviesAPI

    init(moviesAPI: MoviesAPI) {
        self.moviesAPI = moviesAPI
    }

    func getMovies(categoryType: String) -> Observable<Result<[Show], APIError>> {
        moviesAPI.getMovies(categoryType: categoryType).map { result in
            switch result {
            case .success(let movies):
                let result = movies.map { $0.toShow() }
                return .success(result)
            case .failure(let error):
                debugPrint("Failed to fetch movies \(error)")
                return .failure(error)
            }
        }
    }

    func getTVShows(categoryType: String) -> Observable<Result<[Show], APIError>> {
        moviesAPI.getTVShows(categoryType: categoryType).map { result in
            switch result {
            case .success(let tvShows):
                let result = tvShows.map { $0.toShow() }
                return .success(result)
            case .failure(let error):
                debugPrint("Failed to fetch tvShows \(error)")
                return .failure(error)
            }
        }
    }

    func getRecommendedShowsForMovie(id: String) -> Observable<Result<[Show], APIError>> {
        moviesAPI.getRecommendedShowsByMovie(id: id).map { result in
            switch result {
            case .success(let movies):
                let result = movies.map { $0.toShow() }
                return .success(result)
            case .failure(let error):
                debugPrint("Failed to fetch recommended movies \(error)")
                return .failure(error)
            }
        }
    }

    func getRecommendedShowsForTVShow(id: String) -> Observable<Result<[Show], APIError>> {
        moviesAPI.getRecommendedShowsByTVShow(id: id).map { result in
            switch result {
            case .success(let tvShows):
                let result = tvShows.map { $0.toShow() }
                return .success(result)
            case .failure(let error):
                debugPrint("Failed to fetch recommended tvshows \(error)")
                return .failure(error)
            }
        }
    }

    func getMovieSearchResults(from query: String) -> Observable<Result<[Show], APIError>> {
        moviesAPI.getMovieSearchResults(from: query).map { result in
            switch result {
            case .success(let movies):
                let result = movies.map { $0.toShow() }
                return .success(result)
            case .failure(let error):
                debugPrint("Failed to fetch movie search results \(error)")
                return .failure(error)
            }
        }
    }

    func getTVShowsSearchResults(from query: String) -> Observable<Result<[Show], APIError>> {
        moviesAPI.getTVShowsSearchResults(from: query).map { result in
            switch result {
            case .success(let tvShows):
                let result = tvShows.map { $0.toShow() }
                return .success(result)
            case .failure(let error):
                debugPrint("Failed to fetch tv show search results \(error)")
                return .failure(error)
            }
        }
    }
}

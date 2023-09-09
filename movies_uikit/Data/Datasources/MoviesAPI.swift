//
//  MoviesAPI.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

/// For Movies
class MoviesAPI {
    let httpClient: HTTPClient
    let localStorage: LocalStorage

    init(httpClient: HTTPClient, localStorage: LocalStorage) {
        self.httpClient = httpClient
        self.localStorage = localStorage
    }

    func getMovies(
        categoryType: String,
        completion: @escaping (Result<[Movie], Error>) -> Void
    ) {
        let headers = ["Authorization": "Bearer \(HTTPConstants.Auth.tmdbAuthToken)"]

        httpClient.get(
            url: HTTPConstants.Endpoints.getShows(
                showType: "movie",
                categoryType: categoryType
            ).url,
            headers: headers,
            parameters: nil,
            response: MoviesResponse.self
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getTVShows(
        categoryType: String,
        completion: @escaping (Result<[TVShow], Error>) -> Void
    ) {
        let headers = ["Authorization": "Bearer \(HTTPConstants.Auth.tmdbAuthToken)"]

        httpClient.get(
            url: HTTPConstants.Endpoints.getShows(
                showType: "tv",
                categoryType: categoryType
            ).url,
            headers: headers,
            parameters: nil,
            response: TVShowsResponse.self
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getRecommendedShowsByMovie(
        id: String,
        completion: @escaping (Result<[Movie], Error>) -> Void
    ) {
        let headers = ["Authorization": "Bearer \(HTTPConstants.Auth.tmdbAuthToken)"]
        httpClient.get(
            url: HTTPConstants.Endpoints.getRecommendedShowsByShowId(
                showType: "movie",
                id: id
            ).url,
            headers: headers,
            parameters: nil,
            response: MoviesResponse.self
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getRecommendedShowsByTVShow(
        id: String,
        completion: @escaping (Result<[TVShow], Error>) -> Void
    ) {
        let headers = ["Authorization": "Bearer \(HTTPConstants.Auth.tmdbAuthToken)"]

        httpClient.get(
            url: HTTPConstants.Endpoints.getRecommendedShowsByShowId(
                showType: "tv",
                id: id
            ).url,
            headers: headers,
            parameters: nil,
            response: TVShowsResponse.self
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

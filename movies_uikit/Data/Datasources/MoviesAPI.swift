//
//  MoviesAPI.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import RxSwift

/// For Movies
class MoviesAPI {
    let httpClient: HTTPClient
    let localStorage: LocalStorage

    init(httpClient: HTTPClient, localStorage: LocalStorage) {
        self.httpClient = httpClient
        self.localStorage = localStorage
    }

    func getMovies(categoryType: String) -> Observable<Result<[MovieDTO], APIError>> {
        let headers = ["Authorization": "Bearer \(HTTPConstants.Auth.tmdbAuthToken)"]

        return httpClient.get(
            url: HTTPConstants.Endpoints.getShows(
                showType: "movie",
                categoryType: categoryType
            ).url,
            headers: headers,
            parameters: nil,
            response: MoviesResponse.self
        ).map { result in
            switch result {
            case .success(let response):
                return .success(response.results)
            case .failure(let error):
                return .failure(error)
            }
        }
    }

    func getTVShows(categoryType: String) -> Observable<Result<[TVShowDTO], APIError>> {
        let headers = ["Authorization": "Bearer \(HTTPConstants.Auth.tmdbAuthToken)"]

        return httpClient.get(
            url: HTTPConstants.Endpoints.getShows(
                showType: "tv",
                categoryType: categoryType
            ).url,
            headers: headers,
            parameters: nil,
            response: TVShowsResponse.self
        ).map { result in
            switch result {
            case .success(let response):
                return .success(response.results)
            case .failure(let error):
                return .failure(error)
            }
        }
    }

    func getRecommendedShowsByMovie(id: String) -> Observable<Result<[MovieDTO], APIError>> {
        let headers = ["Authorization": "Bearer \(HTTPConstants.Auth.tmdbAuthToken)"]

        return httpClient.get(
            url: HTTPConstants.Endpoints.getRecommendedShowsByShowId(
                showType: "movie",
                id: id
            ).url,
            headers: headers,
            parameters: nil,
            response: MoviesResponse.self
        ).map { result in
            switch result {
            case .success(let response):
                return .success(response.results)
            case .failure(let error):
                return .failure(error)
            }
        }
    }

    func getRecommendedShowsByTVShow(id: String) -> Observable<Result<[TVShowDTO], APIError>> {
        let headers = ["Authorization": "Bearer \(HTTPConstants.Auth.tmdbAuthToken)"]

        return httpClient.get(
            url: HTTPConstants.Endpoints.getRecommendedShowsByShowId(
                showType: "tv",
                id: id
            ).url,
            headers: headers,
            parameters: nil,
            response: TVShowsResponse.self
        ).map { result in
            switch result {
            case .success(let response):
                return .success(response.results)
            case .failure(let error):
                return .failure(error)
            }
        }
    }

    func getTVShowsSearchResults(from query: String) -> Observable<Result<[TVShowDTO], APIError>> {
        let headers = ["Authorization": "Bearer \(HTTPConstants.Auth.tmdbAuthToken)"]

        return httpClient.get(
            url: HTTPConstants.Endpoints.search(
                showType: "tv",
                name: query
            ).url,
            headers: headers,
            parameters: nil,
            response: TVShowsResponse.self
        ).map { result in
            switch result {
            case .success(let response):
                .success(response.results)
            case .failure(let error):
                .failure(error)
            }
        }
    }

    func getMovieSearchResults(from query: String) -> Observable<Result<[MovieDTO], APIError>> {
        let headers = ["Authorization": "Bearer \(HTTPConstants.Auth.tmdbAuthToken)"]

        return httpClient.get(
            url: HTTPConstants.Endpoints.search(
                showType: "movie",
                name: query
            ).url,
            headers: headers,
            parameters: nil,
            response: MoviesResponse.self
        ).map { result in
            switch result {
            case .success(let response):
                .success(response.results)
            case .failure(let error):
                .failure(error)
            }
        }
    }
}

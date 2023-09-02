//
//  MoviesAPI.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import Alamofire

/// For Movies
class MoviesAPI {
    let httpClient: HTTPClient
    let localStorage: LocalStorage

    init(httpClient: HTTPClient, localStorage: LocalStorage) {
        self.httpClient = httpClient
        self.localStorage = localStorage
    }

    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        var headers = HTTPHeaders()
        headers.add(name: "Authorization", value: "Bearer \(APIConstants.Auth.tmdbAuthToken)")
        httpClient.get(url: APIConstants.Endpoints.getPopularMovies.url, headers: headers, parameters: nil, response: PopularMoviesResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

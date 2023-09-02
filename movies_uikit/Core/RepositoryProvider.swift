//
//  RepositoryProvider.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

class RepositoryProvider {
    let authRepository: AuthRepository
    let moviesRepository: MoviesRepository

    private let httpClient: HTTPClient
    private let localStorage: LocalStorage
    private let authAPI: AuthAPI
    private let moviesAPI: MoviesAPI

    init() {
        // External services
        self.httpClient = HTTPClientImpl()
        self.localStorage = LocalStorageImpl()

        // APIs interact with http client and local storage
        self.authAPI = AuthAPI(httpClient: httpClient)
        self.moviesAPI = MoviesAPI(httpClient: httpClient, localStorage: localStorage)

        // Repositories interact only directly with APIs
        self.authRepository = AuthRepositoryImpl(authAPI: authAPI)
        self.moviesRepository = MoviesRepositoryImpl(moviesAPI: moviesAPI)
    }
}

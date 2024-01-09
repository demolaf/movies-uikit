//
//  RepositoryProvider.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

class RepositoryProvider {
    static let shared = RepositoryProvider()

    let authRepository: AuthRepository
    let moviesRepository: MoviesRepository
    let userRepository: UserRepository

    private let httpClient: HTTPClient
    private let localStorage: LocalStorage
    private let authAPI: AuthAPI
    private let moviesAPI: MoviesAPI
    private let userAPI: UserAPI

    private init() {
        // External services
        self.httpClient = HTTPURLSessionClientImpl()
        self.localStorage = LocalStorageImpl()

        // APIs interact with http client and local storage
        self.authAPI = AuthAPI(httpClient: httpClient)
        self.moviesAPI = MoviesAPI(httpClient: httpClient, localStorage: localStorage)
        self.userAPI = UserAPI(localStorage: localStorage)

        // Repositories interact only directly with APIs
        self.authRepository = AuthRepositoryImpl(authAPI: authAPI)
        self.moviesRepository = MoviesRepositoryImpl(moviesAPI: moviesAPI)
        self.userRepository = UserRepositoryImpl(userAPI: userAPI)
    }
}

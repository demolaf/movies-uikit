//
//  MoviesAPI.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

/// For Movies
class MoviesAPI {
    let apiClient: APIClient
    let localStorage: LocalStorage
    
    init(apiClient: APIClient, localStorage: LocalStorage) {
        self.apiClient = apiClient
        self.localStorage = localStorage
    }
}

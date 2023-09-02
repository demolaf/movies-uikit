//
//  AuthRepositoryImpl.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

class AuthRepositoryImpl: AuthRepository {
    private let authAPI: AuthAPI

    init(authAPI: AuthAPI) {
        self.authAPI = authAPI
    }

    func getRequestToken(completion: @escaping (Bool) -> Void) {
        authAPI.getRequestToken { result in
            completion(result)
        }
    }

    func getSessionId(completion: @escaping (Bool) -> Void) {
        authAPI.createSessionId { result in
            completion(result)
        }
    }
}

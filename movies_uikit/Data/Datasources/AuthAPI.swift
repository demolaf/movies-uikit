//
//  AuthAPI.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

class AuthAPI {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func getRequestToken(completion: @escaping (Bool) -> Void) {
        httpClient.get(url: APIConstants.Endpoints.getRequestToken.url, headers: nil, parameters: nil, response: RequestTokenResponse.self) { result in
            switch result {
            case .success(let response):
                APIConstants.Auth.requestToken = response.requestToken
                completion(true)
            case .failure(let error):
                debugPrint("Error Getting Request Token \(error)")
                completion(false)
            }
        }
    }

    func createSessionId(completion: @escaping (Bool) -> Void) {
        let body = CreateSession(requestToken: APIConstants.Auth.requestToken)

        httpClient.post(url: APIConstants.Endpoints.createSessionId.url, parameters: body, response: CreateSessionResponse.self) { result in
            switch result {
            case .success(let response):
                APIConstants.Auth.sessionId = response.sessionId
                debugPrint("Session id here: \(APIConstants.Auth.sessionId)")
                completion(true)
            case .failure(let error):
                debugPrint("Error creating session Id \(error)")
                completion(false)
            }
        }
    }
}

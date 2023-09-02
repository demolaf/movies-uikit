//
//  Environment.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

public enum Environment {
    enum Keys {
        static let tmdbApiKey = "API_KEY"
        static let tmdbAuthToken = "AUTH_TOKEN"
    }

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }

        return dict
    }()

    static let tmdbApiKey: String = {
        guard let apiKeyString = Environment.infoDictionary[Keys.tmdbApiKey] as? String else {
            fatalError("API_KEY not set in plist")
        }

        return apiKeyString
    }()

    static let tmdbAuthToken: String = {
        guard let authTokenString = Environment.infoDictionary[Keys.tmdbAuthToken] as? String else {
            fatalError("AUTH_TOKEN not set in plist")
        }

        return authTokenString
    }()
}

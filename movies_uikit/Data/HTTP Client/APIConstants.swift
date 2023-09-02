//
//  APIConstants.swift
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

class APIConstants {
    struct Auth {
        static let tmdbAPIKey = Environment.tmdbApiKey
        static let tmdbAuthToken = Environment.tmdbAuthToken
        static let tmdbBaseUrl = "api.themoviedb.org/3"
        static var sessionId = ""
        static var requestToken = ""
    }

    enum Endpoints {
        static let httpUrlScheme = "http://"
        static let httpsUrlScheme = "https://"
        static let baseUrlPrefix = "\(Endpoints.httpsUrlScheme)\(Auth.tmdbBaseUrl)"
        static let apiKeyParam = "?api_key=\(Auth.tmdbAPIKey)"

        case createSessionId
        case getRequestToken
        case login
        case webAuth
        case getPopularMovies

        var stringValue: String {
            switch self {
            case .getRequestToken:
                return Endpoints.baseUrlPrefix + "/authentication/token/new" + Endpoints.apiKeyParam
            case .createSessionId:
                return Endpoints.baseUrlPrefix + "/authentication/session/new" + Endpoints.apiKeyParam
            case .login:
                return Endpoints.baseUrlPrefix + "/authentication/token/validate_with_login" + Endpoints.apiKeyParam
            case .webAuth:
                return "https://www.themoviedb.org/authenticate/\(Auth.requestToken)?redirect_to=movies-uikit:authenticate"
            case .getPopularMovies:
                return Endpoints.baseUrlPrefix + "/movie/popular"
            }
        }

        var url: URL? {
            // This handles converting string to URL and accepting spaces in query params
            return URL(string: stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        }
    }
}
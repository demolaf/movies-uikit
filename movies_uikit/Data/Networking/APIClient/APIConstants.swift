//
//  APIConstants.swift
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation



class APIConstants {
    struct Auth {
        static let tmdbAPIKey = Environment.tmdbApiKey
    }
    
    enum Endpoints {
        static let httpUrlScheme = "http://"
        static let httpsUrlScheme = "https://"
        
        case getPopularMovies
        
        var stringValue: String {
            switch self {
            case .getPopularMovies:
                return ""
            }
        }
        
        var url: URL? {
            // This handles converting string to URL and accepting spaces in query params
            return URL(string: stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        }
    }
}

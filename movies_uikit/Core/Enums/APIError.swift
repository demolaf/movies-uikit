//
//  APIError.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 08/01/2024.
//

import Foundation

enum APIError: Error {
    case failedToFetchData(message: String? = nil)
    case failedToSendData(message: String? = nil)
}

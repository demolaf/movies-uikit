//
//  RequestTokenResponse.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

struct RequestTokenResponse: Decodable {
    let success: Bool
    let expiresAt: String
    let requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}

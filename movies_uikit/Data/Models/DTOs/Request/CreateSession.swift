//
//  CreateSession.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

struct CreateSession: Encodable {
    let requestToken: String

    enum CodingKeys: String, CodingKey {
        case requestToken = "request_token"
    }
}

//
//  CreateSessionResponse.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

struct CreateSessionResponse: Decodable {
    let success: Bool
    let sessionId: String

    enum CodingKeys: String, CodingKey {
        case success
        case sessionId = "session_id"
    }
}

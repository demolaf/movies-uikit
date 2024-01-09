//
//  HTTPClient.swift
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import RxSwift

protocol HTTPClient {
    /// GET Method
    @discardableResult
    func get<ResponseType: Decodable>(
        url: URL?,
        headers: [String: String]?,
        parameters: [String: String]?,
        response: ResponseType.Type
    ) -> Observable<Result<ResponseType, APIError>>

    /// POST Method
    @discardableResult
    func post<ResponseType: Decodable>(
        url: URL?,
        headers: [String: String]?,
        parameters: Encodable,
        response: ResponseType.Type
    ) -> Observable<Result<ResponseType, APIError>>
}

//
//  HTTPClient.swift
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import Alamofire

protocol HTTPClient {
    /// GET Method
    @discardableResult
    func get<ResponseType: Decodable>(
        url: URL?,
        headers: HTTPHeaders?,
        parameters: Parameters?,
        response: ResponseType.Type,
        completion: @escaping (Result<ResponseType, Error>) -> Void
    ) -> DataRequest?

    /// POST Method
    @discardableResult
    func post<ResponseType: Decodable>(
        url: URL?,
        parameters: Encodable,
        response: ResponseType.Type,
        completion: @escaping (Result<ResponseType, Error>) -> Void
    ) -> DataRequest?

}

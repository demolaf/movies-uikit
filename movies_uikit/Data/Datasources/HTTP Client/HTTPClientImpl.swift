//
//  HTTPClientImpl.swift
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import Alamofire

class HTTPClientImpl: HTTPClient {

    func get<ResponseType: Decodable>(
        url: URL?,
        headers: HTTPHeaders?,
        parameters: Parameters?,
        response: ResponseType.Type,
        completion: @escaping (Result<ResponseType, Error>
        ) -> Void) -> DataRequest? {
        guard let url = url else {
            return nil
        }

        let request = AF.request(
            url, method: HTTPMethod.get,
            parameters: parameters,
            headers: headers
        ).responseDecodable(of: ResponseType.self) { response in
            switch response.result {
            case .success(let responseObject):
                completion(.success(responseObject))
            case .failure(let error):
                completion(.failure(error))
            }
        }

        request.resume()
        return request
    }

    func post<ResponseType: Decodable>(
        url: URL?,
        parameters: Encodable,
        response: ResponseType.Type,
        completion: @escaping (Result<ResponseType, Error>
        ) -> Void) -> DataRequest? {
        guard let url = url else {
            return nil
        }

        let request = AF.request(
            url,
            method: HTTPMethod.post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default)
            .responseDecodable(of: ResponseType.self) { response in
            switch response.result {
            case .success(let responseObject):
                completion(.success(responseObject))
            case .failure(let error):
                completion(.failure(error))
            }
        }

        request.resume()
        return request
    }

}

//
//  HTTPURLSessionClientImpl.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 08/01/2024.
//

import Foundation
import RxSwift

class HTTPURLSessionClientImpl: HTTPClient {
    func get<ResponseType: Decodable>(
        url: URL?,
        headers: [String: String]?,
        parameters: [String: String]?,
        response: ResponseType.Type
    ) -> Observable<Result<ResponseType, APIError>> {
        guard let url = url else {
            return Observable.just(.failure(.failedToFetchData(message: "url is nil")))
        }
        let response = Observable.just(url)
            .map { url -> URLRequest in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                headers?.forEach { (key: String, value: String) in
                    request.addValue(value, forHTTPHeaderField: key)
                }
                return request
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                URLSession.shared.rx.response(request: request)
            }
            .map { _, data -> Result<ResponseType, APIError> in
                do {
                    let response = try JSONDecoder().decode(ResponseType.self, from: data)
                    return .success(response)
                } catch {
                    return .failure(.failedToFetchData(message: error.localizedDescription))
                }
            }
        return response
    }

    func post<ResponseType: Decodable>(
        url: URL?,
        headers: [String: String]?,
        parameters: Encodable,
        response: ResponseType.Type
    ) -> Observable<Result<ResponseType, APIError>> {
        guard let url = url else {
            return Observable.just(.failure(.failedToSendData(message: "url is nil")))
        }
        let response = Observable.just(url)
            .map { url -> URLRequest in
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                headers?.forEach { (key: String, value: String) in
                    request.addValue(value, forHTTPHeaderField: key)
                }
                request.httpBody = try? JSONEncoder().encode(parameters)
                return request
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                URLSession.shared.rx.response(request: request)
            }
            .map { _, data -> Result<ResponseType, APIError> in
                do {
                    let response = try JSONDecoder().decode(ResponseType.self, from: data)
                    return .success(response)
                } catch {
                    return .failure(.failedToSendData(message: error.localizedDescription))
                }
            }
        return response
    }
}

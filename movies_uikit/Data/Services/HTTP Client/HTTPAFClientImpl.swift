//
//  HTTPAFClientImpl.swift
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import Alamofire
import RxSwift

class HTTPAFClientImpl: HTTPClient {
    func get<ResponseType: Decodable>(
        url: URL?,
        headers: [String: String]?,
        parameters: [String: String]?,
        response: ResponseType.Type
    ) -> Observable<Result<ResponseType, APIError>> {
        guard let url = url else {
            return Observable.just(.failure(.failedToFetchData(message: "url is nil")))
        }

        var httpHeaders = HTTPHeaders()
        if let headers = headers {
            httpHeaders = HTTPHeaders(headers)
        }

        return Observable<Result<ResponseType, APIError>>.create { observer in
            _ = AF.request(
                url,
                method: HTTPMethod.get,
                parameters: parameters,
                headers: httpHeaders
            ).responseDecodable(of: ResponseType.self) { response in
                switch response.result {
                case .success(let responseObject):
                    observer.onNext(.success(responseObject))
                case .failure(let error):
                    observer.onNext(.failure(.failedToFetchData(message: error.localizedDescription)))
                }
            }
            return Disposables.create()
        }
    }

    func post<ResponseType: Decodable>(
        url: URL?,
        headers: [String: String]?,
        parameters: Encodable,
        response: ResponseType.Type
    ) -> Observable<Result<ResponseType, APIError>> {
        guard let url = url else {
            return Observable.just(.failure(.failedToFetchData(message: "url is nil")))
        }

        var httpHeaders = HTTPHeaders()
        if let headers = headers {
            httpHeaders = HTTPHeaders(headers)
        }

        return Observable<Result<ResponseType, APIError>>.create { observer in
            _ = AF.request(
                url,
                method: HTTPMethod.post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default,
                headers: httpHeaders)
            .responseDecodable(of: ResponseType.self) { response in
                switch response.result {
                case .success(let responseObject):
                    observer.onNext(.success(responseObject))
                case .failure(let error):
                    observer.onNext(.failure(.failedToSendData(message: error.localizedDescription)))
                }
            }
            return Disposables.create()
        }
    }

}

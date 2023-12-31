//
//  AuthRepository.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation

protocol AuthRepository {
    func getRequestToken(completion: @escaping (Bool) -> Void)
    func getSessionId(completion: @escaping (Bool) -> Void)
}

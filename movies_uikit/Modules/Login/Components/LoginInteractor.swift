//
//  LoginInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import UIKit

protocol LoginInteractorDelegate: AnyObject {
    var presenter: LoginPresenterDelegate? { get set }

    func loginWithWebAuth()
}

/// - Calls methods in `Repositories`
class LoginInteractor: LoginInteractorDelegate {
    var presenter: LoginPresenterDelegate?

    var authRepository: AuthRepository?

    func loginWithWebAuth() {
        authRepository?.getRequestToken(completion: { success in
            if success {
                guard let url = HTTPConstants.Endpoints.webAuth.url else {
                    return
                }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
    }
}

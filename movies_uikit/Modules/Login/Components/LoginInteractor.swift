//
//  LoginInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import UIKit

protocol LoginInteractor: AnyObject {
    var presenter: LoginPresenter? { get set }

    func loginWithWebAuth()
}

/// - Calls methods in `Repositories`
class LoginInteractorImpl: LoginInteractor {
    var presenter: LoginPresenter?

    var authRepository: AuthRepository?

    func loginWithWebAuth() {
        authRepository?.getRequestToken { success in
            if success {
                guard let url = HTTPConstants.Endpoints.webAuth.url else {
                    return
                }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

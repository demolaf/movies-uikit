//
//  LoginInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import UIKit

protocol LoginInteractorDelegate: AnyInteractor, AnyObject {
    func loginWithWebAuth()
}

/// - Calls methods in `Repositories`
class LoginInteractor: LoginInteractorDelegate {
    var presenter: AnyPresenter?

    var authRepository: AuthRepository?

    func loginWithWebAuth() {
        authRepository?.getRequestToken(completion: { success in
            if success {
                let url = HTTPConstants.Endpoints.webAuth.url
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
        })
    }
}

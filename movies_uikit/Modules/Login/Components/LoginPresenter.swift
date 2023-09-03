//
//  LoginPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import UIKit

protocol LoginPresenterDelegate: AnyObject {
    var view: LoginViewDelegate? { get set }
    var interactor: LoginInteractorDelegate? { get set }
    var router: LoginRouterDelegate? { get set }

    func initialize()
    func loginWithWebAuthButtonPressed()
}

/// - Updates the `View`
/// - Calls methods in the `Interactor` triggered by the `View`
/// - Calls methods in the `Router`
class LoginPresenter: LoginPresenterDelegate {
    var view: LoginViewDelegate?

    var router: LoginRouterDelegate?

    var interactor: LoginInteractorDelegate?

    func initialize() {}

    func loginWithWebAuthButtonPressed() {
        interactor?.loginWithWebAuth()
    }
}

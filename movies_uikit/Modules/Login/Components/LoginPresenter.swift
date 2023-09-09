//
//  LoginPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import UIKit

protocol LoginPresenter: AnyObject {
    var view: LoginView? { get set }
    var interactor: LoginInteractor? { get set }
    var router: LoginRouter? { get set }

    func initialize()
    func loginWithWebAuthButtonPressed()
}

/// - Updates the `View`
/// - Calls methods in the `Interactor` triggered by the `View`
/// - Calls methods in the `Router`
class LoginPresenterImpl: LoginPresenter {
    var view: LoginView?

    var router: LoginRouter?

    var interactor: LoginInteractor?

    func initialize() {}

    func loginWithWebAuthButtonPressed() {
        interactor?.loginWithWebAuth()
    }
}

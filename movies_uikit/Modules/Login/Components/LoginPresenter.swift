//
//  LoginPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import UIKit

protocol LoginPresenterDelegate: AnyPresenter, AnyObject {
    func loginWithWebAuthButtonPressed()
}

/// - Updates the `View`
/// - Calls methods in the `Interactor` triggered by the `View`
/// - Calls methods in the `Router`
class LoginPresenter: LoginPresenterDelegate {
    var view: AnyView?

    var router: AnyRouter?

    var interactor: AnyInteractor?

    func loginWithWebAuthButtonPressed() {
        let interactor = interactor as? LoginInteractor
        interactor?.loginWithWebAuth()

    }
}

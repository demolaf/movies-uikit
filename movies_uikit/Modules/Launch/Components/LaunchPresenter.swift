//
//  LaunchPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol LaunchPresenterDelegate: AnyPresenter, AnyObject {
    func initialize()
}

/// - Updates the `View`
/// - Calls methods in the `Interactor` triggered by the `View`
/// - Calls methods in the `Router`
class LaunchPresenter: LaunchPresenterDelegate {
    var view: AnyView?

    var router: AnyRouter?

    var interactor: AnyInteractor?

    func initialize() {
        print("Initializing launch")
        // TODO: Handle authentication here, check if signed in or not
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            let vc = self.view as? UIViewController

            if let vc = vc {
                self.router?.push(to: Routes.mainTab, from: vc)
            }
        }
    }
}

//
//  LaunchPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol LaunchPresenterDelegate: AnyObject {
    var view: LaunchViewDelegate? { get set }
    var interactor: LaunchInteractorDelegate? { get set }
    var router: LaunchRouterDelegate? { get set }

    func initialize()
}

/// - Updates the `View`
/// - Calls methods in the `Interactor` triggered by the `View`
/// - Calls methods in the `Router`
class LaunchPresenter: LaunchPresenterDelegate {
    var view: LaunchViewDelegate?

    var router: LaunchRouterDelegate?

    var interactor: LaunchInteractorDelegate?

    func initialize() {
        // TODO: Handle authentication here, check if signed in or not
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let vc = self.view as? UIViewController

            if let vc = vc {
                self.router?.push(to: Routes.mainTab, from: vc)
            }
        }
    }
}

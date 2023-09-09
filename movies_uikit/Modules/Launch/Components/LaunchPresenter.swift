//
//  LaunchPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol LaunchPresenter: AnyObject {
    var view: LaunchView? { get set }
    var interactor: LaunchInteractor? { get set }
    var router: LaunchRouter? { get set }

    func initialize()
}

/// - Updates the `View`
/// - Calls methods in the `Interactor` triggered by the `View`
/// - Calls methods in the `Router`
class LaunchPresenterImpl: LaunchPresenter {
    var view: LaunchView?

    var router: LaunchRouter?

    var interactor: LaunchInteractor?

    func initialize() {
        // TODO: Handle authentication here, check if signed in or not
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let vc = self.view as? LaunchViewController

            if let vc = vc {
                self.router?.push(to: Routes.mainTab.vc, from: vc)
            }
        }
    }
}

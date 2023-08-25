//
//  LaunchPresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol LaunchPresenterDelegate: AnyPresenter {
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let vc = self.view as? UIViewController
            
            if let vc = vc {
                self.router?.push(to: Routes.home, from: vc)
            }
        }
    }
}

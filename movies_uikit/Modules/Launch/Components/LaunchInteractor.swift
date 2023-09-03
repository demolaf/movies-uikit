//
//  LaunchInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

protocol LaunchInteractorDelegate: AnyObject {
    var presenter: LaunchPresenterDelegate? { get set }
}

/// - Calls methods in `Repositories`
class LaunchInteractor: LaunchInteractorDelegate {
    var presenter: LaunchPresenterDelegate?
}

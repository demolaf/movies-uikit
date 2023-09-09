//
//  LaunchInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

protocol LaunchInteractor: AnyObject {
    var presenter: LaunchPresenter? { get set }
}

/// - Calls methods in `Repositories`
class LaunchInteractorImpl: LaunchInteractor {
    var presenter: LaunchPresenter?
}

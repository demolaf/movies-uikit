//
//  LaunchInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

protocol LaunchInteractorDelegate: AnyInteractor {}

/// - Calls methods in `Repositories`
class LaunchInteractor: LaunchInteractorDelegate {
    var presenter: AnyPresenter?
}

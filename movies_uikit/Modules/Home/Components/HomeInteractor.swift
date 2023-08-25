//
//  HomeInteractor.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

protocol HomeInteractorDelegate: AnyInteractor {
    // func getUsers()
}

class HomeInteractor: HomeInteractorDelegate {
    var presenter: AnyPresenter?
}

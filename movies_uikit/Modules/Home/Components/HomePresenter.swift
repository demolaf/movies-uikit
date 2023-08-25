//
//  HomePresenter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation

protocol HomePresenterDelegate: AnyPresenter {
    // func interactorDidFetchUsers(with result: Result<[User], Error>)
}

class HomePresenter: HomePresenterDelegate {
    var router: AnyRouter?
    
    var interactor: AnyInteractor?
    
    var view: AnyView?
}

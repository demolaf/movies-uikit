//
//  AppProtocols.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
}

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
}

protocol AnyPresenter {
    var view: AnyView? { get set }
    var interactor: AnyInteractor? { get set }
    var router: AnyRouter? { get set }
}

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    // this is how we tell our app delegate that this is the entry for our application
    var entry: EntryPoint? { get }

    static func route() -> AnyRouter

    func push(to route: Routes, from vc: UIViewController)

    func pop(from vc: UIViewController)
}

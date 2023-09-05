//
//  AppRouter.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

/// Register routes in app
enum Routes: String {
    case launch = "/launch"
    case login = "/login"
    case mainTab = "/mainTab"
    case movies = "/movies"
    case tvShows = "/tvShows"
    case library = "/library"
    case detail = "/detail"

    var vc: UIViewController {
        switch self {
        case .launch:
            return LaunchRouter.route().entry!
        case .login:
            return LoginRouter.route().entry!
        case .mainTab:
            return MainTabBarViewController()
        case .movies:
            return MoviesRouter.route().entry!
        case .tvShows:
            return TVShowsRouter.route().entry!
        case .library:
            return LibraryRouter.route().entry!
        case .detail:
            return DetailRouter.route().entry!
        }
    }
}

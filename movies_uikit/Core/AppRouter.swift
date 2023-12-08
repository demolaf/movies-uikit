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
    case mainTab = "/mainTab"
    case movies = "/movies"
    case tvShows = "/tvShows"
    case library = "/library"
    case detail = "/detail"

    var vc: UIViewController {
        switch self {
        case .launch:
            return LaunchRouterImpl.route().entry!
        case .mainTab:
            return MainTabBarViewController()
        case .movies:
            return MoviesRouterImpl.route().entry!
        case .tvShows:
            return TVShowsRouterImpl.route().entry!
        case .library:
            return LibraryRouterImpl.route().entry!
        case .detail:
            return DetailRouterImpl.route().entry!
        }
    }
}

//
//  MainTabBarViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //
        let moviesVC = Routes.movies.vc
        let tvShowsVC = Routes.tvShows.vc
        let libraryVC = Routes.library.vc

        //
        let nav1 = UINavigationController(rootViewController: moviesVC)
        let nav2 = UINavigationController(rootViewController: tvShowsVC)
        let nav3 = UINavigationController(rootViewController: libraryVC)

        //
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label

        //
        nav1.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "TV Shows", image: UIImage(systemName: "display"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "building.columns"), tag: 3)
        self.tabBar.tintColor = .label

        setViewControllers([nav1, nav2, nav3], animated: false)
    }
}

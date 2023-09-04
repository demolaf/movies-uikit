//
//  LibraryViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import UIKit

protocol LibraryViewDelegate: AnyObject {
    var presenter: LibraryPresenterDelegate? { get set }

    func update(with movies: [Movie])
}

enum LibrarySectionType: String {
    case movies = "Movies"
    case tvShows = "TV Shows"
}

class LibraryViewController: UIViewController, LibraryViewDelegate {

    private let sections = [
        LibrarySectionType.movies,
        LibrarySectionType.tvShows
    ]

    private let leadingBarButtonItems: [UIBarButtonItem] = {
        let barButtonItem = LibraryBarButtonItem()
        return [barButtonItem]
    }()

    private lazy var viewControllers: [UIViewController] = {
        var viewControllers: [UIViewController] = []
        sections.forEach { section in
            let vc = LibrarySectionViewController()
            vc.pageViewController = self
            vc.title = section.rawValue
            viewControllers.append(UINavigationController(rootViewController: vc))
        }
        return viewControllers
    }()

    private lazy var libraryPageVC: UIPageViewController = {
        let pageVC = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        pageVC.setViewControllers(
            [viewControllers.first!],
            direction: .forward,
            animated: true
        )
        return pageVC
    }()

    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let tabBarView: UIView = {
        let tabBar = LibraryTabBarView()
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        return tabBar
    }()

    var presenter: LibraryPresenterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeViewAppearance()
        initializePageController()
        initializeSubviews()

        presenter?.initialize()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
    }

    func update(with movies: [Movie]) {}
}

extension LibraryViewController {

    private func initializeViewAppearance() {
        //
        view.backgroundColor = .systemBackground
        navigationItem.setLeftBarButtonItems(leadingBarButtonItems, animated: true)
    }

    private func initializeSubviews() {
        self.view.addSubview(mainView)
        self.mainView.addSubview(tabBarView)
        self.mainView.addSubview(libraryPageVC.view)
    }

    private func initializePageController() {
        libraryPageVC.delegate = self
        libraryPageVC.dataSource = self

        addChild(libraryPageVC)

        libraryPageVC.didMove(toParent: self)
        view.gestureRecognizers = libraryPageVC.gestureRecognizers
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([

            // Main View Constraints
            mainView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 48),
            mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            // Tab Bar View Constraints
            tabBarView.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 36),
            tabBarView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.1),

            // Library Page VC Constraints
            libraryPageVC.view.topAnchor.constraint(equalTo: self.tabBarView.bottomAnchor, constant: 36),
            libraryPageVC.view.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            libraryPageVC.view.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
            libraryPageVC.view.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor)
        ])
    }
}

extension LibraryViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = viewControllers
            .firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }

        guard viewControllers.count > previousIndex else {
            return nil
        }

        return viewControllers[previousIndex]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = viewControllers
            .firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let viewControllersCount = viewControllers.count

        guard viewControllersCount != nextIndex else {
            return nil
        }

        guard viewControllersCount > nextIndex else {
            return nil
        }

        return viewControllers[nextIndex]
    }
}

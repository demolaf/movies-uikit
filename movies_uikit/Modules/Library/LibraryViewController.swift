//
//  LibraryViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import UIKit
import RxSwift
import RxCocoa

protocol LibraryView: AnyObject {
    var presenter: LibraryPresenter? { get set }

    func update(movies: [Movie])
    func update(tvShows: [TVShow])
}

enum LibrarySectionType: Int {
    case movies
    case tvShows

    var stringValue: String {
        switch self {
        case .movies:
            return "Movies"
        case .tvShows:
            return "TV Shows"
        }
    }
}

class LibraryViewController: UIViewController, LibraryView {

    private let sections = [
        LibrarySectionType.movies,
        LibrarySectionType.tvShows
    ]

    private let leadingBarButtonItems: [UIBarButtonItem] = {
        let barButtonItem = LibraryBarButtonItem()
        return [barButtonItem]
    }()

    private lazy var viewControllers: [ReusableTableViewController] = {
        var viewControllers: [ReusableTableViewController] = []
        sections.forEach { _ in
            let vc = ReusableTableViewController()
            viewControllers.append(vc)
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

    private lazy var tabBarView: LibraryTabBarView = {
        let tabBar = LibraryTabBarView()
        tabBar.delegate = self
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        return tabBar
    }()

    var presenter: LibraryPresenter?

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

    func update(movies: [Movie]) {
        viewControllers[0].items.accept(movies)
    }

    func update(tvShows: [TVShow]) {
        viewControllers[1].items.accept(tvShows)
    }
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
            libraryPageVC.view.topAnchor.constraint(equalTo: self.tabBarView.bottomAnchor, constant: 8),
            libraryPageVC.view.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            libraryPageVC.view.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
            libraryPageVC.view.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor)
        ])
    }
}

extension LibraryViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    func jumpToTab(section: LibrarySectionType) {

        self.tabBarView.changeSelectedTab(section: section)

        switch section {
        case .movies:
            libraryPageVC.setViewControllers([viewControllers[0]], direction: .reverse, animated: true)
        case .tvShows:
            libraryPageVC.setViewControllers([viewControllers[1]], direction: .forward, animated: true)
        }
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if completed,
           let currentViewController = pageViewController.viewControllers?.first as? ReusableTableViewController,
           let currentIndex = viewControllers.firstIndex(of: currentViewController ) {
            let currentTab = LibrarySectionType(rawValue: currentIndex) ?? LibrarySectionType.movies
            self.tabBarView.changeSelectedTab(section: currentTab)
        }
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let viewController = viewController as? ReusableTableViewController,
                let viewControllerIndex = viewControllers.firstIndex(of: viewController) else {
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
        guard let viewController = viewController as? ReusableTableViewController,
                let viewControllerIndex = viewControllers.firstIndex(of: viewController) else {
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

extension LibraryViewController: LibraryTabBarViewDelegate {
    func didTapMovieTabBar() {
        self.jumpToTab(section: LibrarySectionType.movies)
    }

    func didTapTVTabBar() {
        self.jumpToTab(section: LibrarySectionType.tvShows)
    }
}

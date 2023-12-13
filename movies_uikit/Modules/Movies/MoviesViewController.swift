//
//  MoviesViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit
import RxSwift

enum MoviesSectionType {
    case carousel(movies: [Show])
    case topSection(movies: [Show])
    case bottomSection(movies: [Show])

    var titleValue: String {
        switch self {
        case .carousel:
            return ""
        case .topSection:
            return "New"
        case .bottomSection:
            return "Top Rated"
        }
    }
}

protocol MoviesView: AnyObject {
    var presenter: MoviesPresenter? { get set }
    var searchResults: BehaviorSubject<[Show]> { get }

    func update(
        popularMovies: [Show],
        newMovies: [Show],
        upcomingMovies: [Show]
    )
}

class MoviesViewController: UIViewController, MoviesView {

    // MARK: Views

    private let leadingBarButtonItems: [UIBarButtonItem] = {
        let barButtonItem = MoviesBarButtonItem()
        return [barButtonItem]
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
                return self.createSectionLayout(section: sectionIndex)})

        collectionView.register(
            CarouselItemCollectionViewCell.self,
            forCellWithReuseIdentifier: CarouselItemCollectionViewCell.reuseId
        )

        collectionView.register(
            SubSectionItemCollectionViewCell.self,
            forCellWithReuseIdentifier: SubSectionItemCollectionViewCell.reuseId
        )

        collectionView.register(
            HeaderCollectionResuableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderCollectionResuableView.reuseId
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    private lazy var searchController: UISearchController = {
        let resuableTableVC = ReusableTableViewController()
        resuableTableVC.delegate = self
        let searchController = UISearchController(
            searchResultsController: resuableTableVC
        )
        searchController.searchBar.placeholder = "Search for a movie by title"
        return searchController
    }()

    private let loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    // MARK: Properties

    var presenter: MoviesPresenter?

    var sections = [MoviesSectionType]()

    let searchResults = BehaviorSubject<[Show]>(value: [])

    private let disposeBag = DisposeBag()

    // MARK: Initialization

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewAppearance()
        initializeSubviews()
        setupCollectionViews()

        presenter?.initialize()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
    }

    // MARK: Private Methods

    private func initializeSubviews() {
        // NOTE: Must be the first view added to parent
        // subviews to enable title to scroll on collection view scrolled
        view.addSubview(collectionView)
        view.addSubview(loadingIndicator)
        searchController.searchResultsUpdater = self
    }

    private func setupCollectionViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
    }

    func update(popularMovies: [Show], newMovies: [Show], upcomingMovies: [Show]) {
        sections.append(.carousel(movies: popularMovies))
        sections.append(.topSection(movies: newMovies))
        sections.append(.bottomSection(movies: upcomingMovies))

        loadingIndicator.stopAnimating()
        collectionView.reloadData()
        collectionView.isHidden = false
    }
}

// MARK: Appearance

extension MoviesViewController {

    private func setupViewAppearance() {
        //
        view.backgroundColor = .systemBackground

        //
        navigationItem.setLeftBarButtonItems(leadingBarButtonItems, animated: true)
        navigationItem.hidesBackButton = true
        navigationItem.searchController = searchController
    }

    private func applyConstraints() {
        loadingIndicator.center = view.center

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 36
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController
            .searchBar.rx
            .text
            .debounce(.seconds(2), scheduler: MainScheduler())
            .subscribe { [weak self] text in
                guard let text = text else {
                    return
                }
                self?.presenter?.searchForMovie(with: text)
            }
            .disposed(by: disposeBag)

        let vc = searchController.searchResultsController as? ReusableTableViewController
        searchResults
            .subscribe(onNext: { movies in
                vc?.items.accept(movies)
            })
            .disposed(by: disposeBag)
    }
}

extension MoviesViewController: ReusableTableViewControllerDelegate {
    func didTapItem(item: Show) {
        presenter?.movieItemTapped(item: item)
    }
}

//
//  TVShowsViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import UIKit
import RxSwift
import RxRelay

protocol TVShowsView: AnyObject {
    var presenter: TVShowsPresenter? { get set }
    // this is a computed property?
    var searchResults: BehaviorSubject<[Show]> { get }

    func update(popularTVShows: [Show], topRatedTVShows: [Show], onTheAirTVShows: [Show])
}

enum TVSectionType {
    case popular(tvShows: [Show])
    case topRated(tvShows: [Show])
    case onTheAir(tvShows: [Show])
}

class TVShowsViewController: UIViewController, TVShowsView {

    // MARK: Views

    private let leadingBarButtonItems: [UIBarButtonItem] = {
        let barButtonItem = TVShowsBarButtonItem()
        return [barButtonItem]
    }()

    private lazy var searchBar: UISearchController = {
        let resuableTableVC = ReusableTableViewController()
        resuableTableVC.delegate = self
        let searchBar = UISearchController(
            searchResultsController: resuableTableVC
        )
        searchBar.searchBar.placeholder = "Search for a tv show by title"
        searchBar.searchBar.searchBarStyle = .minimal
        return searchBar
    }()

    lazy var collectionView: UICollectionView = {
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

    private let loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    // MARK: Properties

    var presenter: TVShowsPresenter?

    var sections: [TVSectionType] = []

    let searchResults = BehaviorSubject<[Show]>(value: [])

    let disposeBag = DisposeBag()

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
        searchBar.searchResultsUpdater = self
    }

    private func setupCollectionViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
    }

    func update(
        popularTVShows: [Show],
        topRatedTVShows: [Show],
        onTheAirTVShows: [Show]
    ) {
        sections.append(.popular(tvShows: popularTVShows))
        sections.append(.topRated(tvShows: topRatedTVShows))
        sections.append(.onTheAir(tvShows: onTheAirTVShows))

        loadingIndicator.stopAnimating()
        collectionView.reloadData()
        collectionView.isHidden = false
    }

    @objc
    private func searchBarButtonItemPressed() {}

    @objc
    private func castBarButtonItemPressed() {}
}

extension TVShowsViewController {

    private func setupViewAppearance() {
        //
        view.backgroundColor = .systemBackground
        navigationItem.setLeftBarButtonItems(leadingBarButtonItems, animated: true)
        navigationItem.searchController = searchBar
        if #available(iOS 16.0, *) {
            navigationItem.preferredSearchBarPlacement = .inline
        } else {
            // Fallback on earlier versions
        }
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

extension TVShowsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }

        presenter?.searchForTVShow(with: text)

        let vc = searchController.searchResultsController as? ReusableTableViewController
        searchResults.subscribe(onNext: { tvShows in
            vc?.items.accept(tvShows)
        }).disposed(by: disposeBag)
    }
}

extension TVShowsViewController: ReusableTableViewControllerDelegate {
    func didTapItem(item: Show) {
        presenter?.tvShowItemTapped(item: item)
    }
}

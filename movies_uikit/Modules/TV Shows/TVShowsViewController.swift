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
    var searchResults: BehaviorSubject<[Show]> { get }

    func update(
        popularTVShows: [Show],
        topRatedTVShows: [Show],
        onTheAirTVShows: [Show]
    )
}

enum TVSectionType {
    case carousel(tvShows: [Show])
    case topSection(tvShows: [Show])
    case bottomSection(tvShows: [Show])

    var titleValue: String {
        switch self {
        case .carousel:
            return ""
        case .topSection:
            return "Top Rated"
        case .bottomSection:
            return "On The Air"
        }
    }
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
        sections.append(.carousel(tvShows: popularTVShows))
        sections.append(.topSection(tvShows: topRatedTVShows))
        sections.append(.bottomSection(tvShows: onTheAirTVShows))

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
        let vc = searchController.searchResultsController as? ReusableTableViewController

        searchResults
            .subscribe(onNext: { tvShows in
                DispatchQueue.main.async {
                    vc?.showLoadingIndicator.onNext(false)
                    vc?.items.accept(tvShows)
                }
            })
            .disposed(by: disposeBag)

        searchController
            .searchBar.rx
            .text
            .do(onNext: { _ in
                vc?.showLoadingIndicator.onNext(true)
            })
            // You have a search text field subscription, which sends its current text to a server API.
            // By using throttle, you can let the user quickly type in words and only send a request to
            // your server after the user has finished typing.
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe { [weak self] text in
                guard let text = text else {
                    return
                }
                self?.presenter?.searchForTVShow(with: text)
            }
            .disposed(by: disposeBag)
    }
}

extension TVShowsViewController: ReusableTableViewControllerDelegate {
    func didTapItem(item: Show) {
        presenter?.tvShowItemTapped(item: item)
    }
}

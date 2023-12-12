//
//  MoviesViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

enum MoviesSectionType {
    case popular(movies: [Show])
    case new(movies: [Show])
    case upcoming(movies: [Show])
}

protocol MoviesView: AnyObject {
    var presenter: MoviesPresenter? { get set }

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

    private var sections = [MoviesSectionType]()

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
        sections.append(.popular(movies: popularMovies))
        sections.append(.new(movies: newMovies))
        sections.append(.upcoming(movies: upcomingMovies))

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

// MARK: - UICollectionView Delegate & DataSource

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        return sections.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        let section = sections[section]
        switch section {
        case .popular(let movies):
            return movies.count
        case .new(let movies):
            return movies.count > 5 ? 5 : movies.count
        case .upcoming(let movies):
            return movies.count > 5 ? 5 : movies.count
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt
        indexPath: IndexPath
    ) -> UICollectionViewCell {

        let type = self.sections[indexPath.section]

        switch type {
        case .popular(let movies):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CarouselItemCollectionViewCell.reuseId,
                for: indexPath
            ) as? CarouselItemCollectionViewCell else {
                return UICollectionViewCell()
            }

            let movie = movies[indexPath.row]
            cell.configureViewData(show: movie)
            return cell
        case .new(let movies):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SubSectionItemCollectionViewCell.reuseId,
                for: indexPath
            ) as? SubSectionItemCollectionViewCell else {
                return UICollectionViewCell()
            }

            let movie = movies[indexPath.row]
            cell.configureViewData(show: movie)
            return cell
        case .upcoming(let movies):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SubSectionItemCollectionViewCell.reuseId,
                for: indexPath
            ) as? SubSectionItemCollectionViewCell else {
                return UICollectionViewCell()
            }

            let movie = movies[indexPath.row]
            cell.configureViewData(show: movie)
            return cell
        }

    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let section = sections[indexPath.section]

        switch section {
        case .popular(movies: let movies):
            self.presenter?.movieItemTapped(item: movies[indexPath.row])
        case .new(movies: let movies):
            self.presenter?.movieItemTapped(item: movies[indexPath.row])
        case .upcoming(movies: let movies):
            self.presenter?.movieItemTapped(item: movies[indexPath.row])
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderCollectionResuableView.reuseId,
            for: indexPath
        ) as? HeaderCollectionResuableView else {
            return UICollectionReusableView()
        }

        let section = sections[indexPath.section]

        switch section {
        case .popular: break
        case .new(let movies):
            headerView.configureHeaderLeadingText(leadingText: "New")
            headerView.viewAllButtonPressedCallback = {
                self.presenter?.viewAllButtonTapped(
                    sectionTitle: "New",
                    items: movies
                )
            }
        case .upcoming(let movies):
            headerView.configureHeaderLeadingText(leadingText: "Upcoming")
            headerView.viewAllButtonPressedCallback = {
                self.presenter?.viewAllButtonTapped(
                    sectionTitle: "Upcoming",
                    items: movies
                )
            }
        }

        return headerView
    }

    func createSectionLayout(
        section: Int
    ) -> NSCollectionLayoutSection {
        let type = sections[section]
        switch type {
        case .popular:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(320),
                    heightDimension: .absolute(250)
                )
            )

            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24)

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(320),
                    heightDimension: .absolute(275)
                ),
                subitems: [item]
            )

            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section
        case .new, .upcoming:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(225)
                )
            )

            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24)
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(275)
                ),
                subitems: [item]
            )

            // Section
            let section = NSCollectionLayoutSection(group: group)

            let footerHeaderSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(50.0)
            )

            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerHeaderSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )

            section.boundarySupplementaryItems = [header]

            section.orthogonalScrollingBehavior = .continuous
            return section
        }
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }

        // presenter?.searchForTVShow(with: text)

//        let vc = searchController.searchResultsController as? ReusableTableViewController
//        searchResults.subscribe(onNext: { tvShows in
//            vc?.items.accept(tvShows)
//        }).disposed(by: disposeBag)
    }
}

extension MoviesViewController: ReusableTableViewControllerDelegate {
    func didTapItem(item: Show) {
        presenter?.movieItemTapped(item: item)
    }
}

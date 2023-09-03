//
//  MoviesViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

enum MoviesSectionType {
    case popular(movies: [Movie])
    case new
    case recommended
}

protocol MoviesViewDelegate: AnyObject {
    var presenter: MoviesPresenterDelegate? { get set }

    func update(with movies: [Movie])
}

class MoviesViewController: UIViewController, MoviesViewDelegate {

    // MARK: Views

    private let leadingBarButtonItems: [UIBarButtonItem] = {
        let barButtonItem = MoviesBarButtonItem()
        return [barButtonItem]
    }()

    private let trailingBarButtonItems: [UIBarButtonItem] = {
        let searchBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: MoviesViewController.self,
            action: #selector(searchBarButtonItemPressed)
        )

        searchBarButtonItem.tintColor = .label

        return [searchBarButtonItem]
    }()

    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return MoviesViewController.createSectionLayout(section: sectionIndex)})

        collectionView.register(
            PopularShowsItemViewCell.self,
            forCellWithReuseIdentifier: PopularShowsItemViewCell.reuseId
        )

        collectionView.register(
            NewAndRecommendedCollectionViewCell.self,
            forCellWithReuseIdentifier: NewAndRecommendedCollectionViewCell.reuseId
        )

        collectionView.register(
            HeaderCollectionResuableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderCollectionResuableView.reuseId
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    // MARK: Properties

    var presenter: MoviesPresenterDelegate?

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
    }

    private func setupCollectionViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func update(with movies: [Movie]) {
        configureCellData(popularMovies: movies)
    }

    // TODO: Should I move this out of here and into presenter?
    private func configureCellData(popularMovies: [Movie]) {
        sections.append(.popular(movies: popularMovies))
        sections.append(.new)
        sections.append(.recommended)
        collectionView.reloadData()
    }

    @objc
    private func searchBarButtonItemPressed() {}
}

// MARK: Appearance

extension MoviesViewController {

    private func setupViewAppearance() {
        //
        view.backgroundColor = .systemBackground

        //
        navigationItem.setLeftBarButtonItems(leadingBarButtonItems, animated: true)
        navigationItem.setRightBarButtonItems(trailingBarButtonItems, animated: true)
        navigationItem.hidesBackButton = true
    }

    private func applyConstraints() {
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
        case .new:
            return 10
        case .recommended:
            return 10
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
                withReuseIdentifier: PopularShowsItemViewCell.reuseId,
                for: indexPath
            ) as? PopularShowsItemViewCell else {
                return UICollectionViewCell()
            }

            let movie = movies[indexPath.row]
            cell.configureViewData(movie: movie)
            return cell
        case .new:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PopularShowsItemViewCell.reuseId,
                for: indexPath
            ) as? PopularShowsItemViewCell else {
                return UICollectionViewCell()
            }
            cell.configureViewData(movie: nil)
            return cell
        case .recommended:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PopularShowsItemViewCell.reuseId,
                for: indexPath
            ) as? PopularShowsItemViewCell else {
                return UICollectionViewCell()
            }
            cell.configureViewData(movie: nil)
            return cell
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
        return headerView
    }

    static func createSectionLayout(
        section: Int
    ) -> NSCollectionLayoutSection {
        switch section {
        case 0:
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
                    heightDimension: .absolute(300)
                ),
                subitems: [item]
            )

            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section
        default:
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
                    heightDimension: .absolute(300)
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

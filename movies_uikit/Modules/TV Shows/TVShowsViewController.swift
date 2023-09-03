//
//  TVShowsViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import UIKit

protocol TVShowsViewDelegate: AnyObject {
    var presenter: TVShowsPresenterDelegate? { get set }

    func update(with tvShows: [TVShow])
}

enum TVSectionType {
    case popular(tvShows: [TVShow])
    case new
    case recommended
}

class TVShowsViewController: UIViewController, TVShowsViewDelegate {

    // MARK: Views

    private let leadingBarButtonItems: [UIBarButtonItem] = {
        let barButtonItem = TVShowsBarButtonItem()
        return [barButtonItem]
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

    var presenter: TVShowsPresenterDelegate?

    private var sections = [TVSectionType]()

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

    func update(with tvShows: [TVShow]) {
        configureCellData(popularTVShows: tvShows)
    }

    private func configureCellData(popularTVShows: [TVShow]) {
        sections.append(.popular(tvShows: popularTVShows))
        sections.append(.new)
        sections.append(.recommended)
        collectionView.reloadData()
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

extension TVShowsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

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
        case .popular(let tvShows):
            return tvShows.count
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
        case .popular(let tvShows):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PopularShowsItemViewCell.reuseId,
                for: indexPath
            ) as? PopularShowsItemViewCell else {
                return UICollectionViewCell()
            }

            let tvShow = tvShows[indexPath.row]
            cell.configureViewData(tv: tvShow)
            return cell
        case .new:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PopularShowsItemViewCell.reuseId,
                for: indexPath
            ) as? PopularShowsItemViewCell else {
                return UICollectionViewCell()
            }
            cell.configureViewData(tv: nil)
            return cell
        case .recommended:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PopularShowsItemViewCell.reuseId,
                for: indexPath
            ) as? PopularShowsItemViewCell else {
                return UICollectionViewCell()
            }
            cell.configureViewData(tv: nil)
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

            let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .absolute(50.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerHeaderSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)

            section.boundarySupplementaryItems = [header]

            section.orthogonalScrollingBehavior = .continuous
            return section
        }
    }
}

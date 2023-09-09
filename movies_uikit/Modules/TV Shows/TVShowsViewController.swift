//
//  TVShowsViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import UIKit

protocol TVShowsView: AnyObject {
    var presenter: TVShowsPresenter? { get set }

    func update(popularTVShows: [TVShow])
    func update(topRatedTVShows: [TVShow])
    func update(onTheAirTVShows: [TVShow])
}

enum TVSectionType {
    case popular(tvShows: [TVShow])
    case topRated(tvShows: [TVShow])
    case onTheAir(tvShows: [TVShow])
}

class TVShowsViewController: UIViewController, TVShowsView {

    // MARK: Views

    private let leadingBarButtonItems: [UIBarButtonItem] = {
        let barButtonItem = TVShowsBarButtonItem()
        return [barButtonItem]
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

    // MARK: Properties

    var presenter: TVShowsPresenter?

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

    func update(popularTVShows: [TVShow]) {
        sections.append(.popular(tvShows: popularTVShows))
        collectionView.reloadData()
    }

    func update(topRatedTVShows: [TVShow]) {
        sections.append(.topRated(tvShows: topRatedTVShows))
        collectionView.reloadData()
    }

    func update(onTheAirTVShows: [TVShow]) {
        sections.append(.onTheAir(tvShows: onTheAirTVShows))
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
        case .topRated(let tvShows):
            return tvShows.count > 5 ? 5 : tvShows.count
        case .onTheAir(let tvShows):
            return tvShows.count > 5 ? 5 : tvShows.count
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
                withReuseIdentifier: CarouselItemCollectionViewCell.reuseId,
                for: indexPath
            ) as? CarouselItemCollectionViewCell else {
                return UICollectionViewCell()
            }

            let tvShow = tvShows[indexPath.row]
            cell.configureViewData(tv: tvShow)
            return cell
        case .topRated(let tvShows):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SubSectionItemCollectionViewCell.reuseId,
                for: indexPath
            ) as? SubSectionItemCollectionViewCell else {
                return UICollectionViewCell()
            }

            let tvShow = tvShows[indexPath.row]
            cell.configureViewData(tv: tvShow)
            return cell
        case .onTheAir(let tvShows):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SubSectionItemCollectionViewCell.reuseId,
                for: indexPath
            ) as? SubSectionItemCollectionViewCell else {
                return UICollectionViewCell()
            }

            let tvShow = tvShows[indexPath.row]
            cell.configureViewData(tv: tvShow)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]

        switch section {
        case .popular(tvShows: let tvShows):
            self.presenter?.tvShowItemTapped(tvShow: tvShows[indexPath.row])
        case .topRated(tvShows: let tvShows):
            self.presenter?.tvShowItemTapped(tvShow: tvShows[indexPath.row])
        case .onTheAir(tvShows: let tvShows):
            self.presenter?.tvShowItemTapped(tvShow: tvShows[indexPath.row])
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
        case .topRated(let tvShows):
            headerView.configureHeaderLeadingText(leadingText: "Top Rated")
            headerView.viewAllButtonPressedCallback = {
                self.presenter?.viewAllButtonTapped(
                    sectionTitle: "Top Rated",
                    tvShows: tvShows
                )
            }
        case .onTheAir(let tvShows):
            headerView.configureHeaderLeadingText(leadingText: "On The Air")
            headerView.viewAllButtonPressedCallback = {
                self.presenter?.viewAllButtonTapped(
                    sectionTitle: "On The Air",
                    tvShows: tvShows
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
        case .topRated, .onTheAir:
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

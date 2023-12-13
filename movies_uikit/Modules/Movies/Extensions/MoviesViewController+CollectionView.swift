//
//  MoviesViewController+CollectionView.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 12/12/2023.
//

import Foundation
import UIKit

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
        case .carousel(let movies):
            return movies.count
        case .topSection(let movies):
            return movies.count > 5 ? 5 : movies.count
        case .bottomSection(let movies):
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
        case .carousel(let movies):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CarouselItemCollectionViewCell.reuseId,
                for: indexPath
            ) as? CarouselItemCollectionViewCell else {
                return UICollectionViewCell()
            }

            let movie = movies[indexPath.row]
            cell.configureViewData(show: movie)
            return cell
        case .topSection(let movies):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SubSectionItemCollectionViewCell.reuseId,
                for: indexPath
            ) as? SubSectionItemCollectionViewCell else {
                return UICollectionViewCell()
            }

            let movie = movies[indexPath.row]
            cell.configureViewData(show: movie)
            return cell
        case .bottomSection(let movies):
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
        case .carousel(movies: let movies):
            self.presenter?.movieItemTapped(item: movies[indexPath.row])
        case .topSection(movies: let movies):
            self.presenter?.movieItemTapped(item: movies[indexPath.row])
        case .bottomSection(movies: let movies):
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
        case .carousel: break
        case .topSection(let movies):
            headerView.configureHeaderLeadingText(leadingText: section.titleValue)
            headerView.viewAllButtonPressedCallback = {
                self.presenter?.viewAllButtonTapped(
                    sectionTitle: section.titleValue,
                    items: movies
                )
            }
        case .bottomSection(let movies):
            headerView.configureHeaderLeadingText(leadingText: section.titleValue)
            headerView.viewAllButtonPressedCallback = {
                self.presenter?.viewAllButtonTapped(
                    sectionTitle: section.titleValue,
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
        case .carousel:
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
        case .topSection, .bottomSection:
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

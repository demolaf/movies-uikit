//
//  RecommendedBasedOnItemView.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 04/09/2023.
//

import UIKit

class RecommendedBasedOnItemView: UIView {

    // TODO: Use Generics to fix all the issues with Movie or TVShow type
    // Replace the below with generics
    var items = [Show]()
    var itemSelectedCallback: ((Show) -> Void)?
    var viewAllItemsCallback: (([Show]) -> Void)?

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
                return self.createSectionLayout(section: sectionIndex)})

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

    override init(frame: CGRect) {
        super.init(frame: frame)

        initializeSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        applyConstraints()
    }

    private func initializeSubviews() {
        collectionView.delegate = self
        collectionView.dataSource = self

        self.addSubview(collectionView)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func createSectionLayout(
        section: Int
    ) -> NSCollectionLayoutSection {
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

    func configureViewItems(items: [Show]) {
        self.items = items
        collectionView.reloadData()
    }
}

extension RecommendedBasedOnItemView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return items.count > 5 ? 5 : items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SubSectionItemCollectionViewCell.reuseId,
            for: indexPath
        ) as? SubSectionItemCollectionViewCell else {
            return UICollectionViewCell()
        }

        let item = items[indexPath.row]

        cell.configureViewData(show: item)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemSelectedCallback?(items[indexPath.row])
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

        headerView.configureHeaderLeadingText(leadingText: "Related to this movie")
        headerView.viewAllButtonPressedCallback = {
            self.viewAllItemsCallback?(self.items)
        }
        return headerView
    }
}

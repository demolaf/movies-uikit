//
//  HomeViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

enum HomeItemSectionType {
    case carousel
    case new
    case recommended
}

protocol HomeViewDelegate: AnyView {
    // func update(with users: [User])
    // func update(with error: String)
}

class HomeViewController: UIViewController, HomeViewDelegate {
    
    // MARK: Views
    
    private let leadingBarButtonItems: [UIBarButtonItem] = {
        let barButtonItem = LeadingBarButtonItem()
        return [barButtonItem]
    }()
    
    private let trailingBarButtonItems: [UIBarButtonItem] = {
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: HomeViewController.self, action: #selector(searchBarButtonItemPressed))
        let castBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "display"), style: .plain, target: HomeViewController.self, action: #selector(castBarButtonItemPressed))
        
        searchBarButtonItem.tintColor = .label
        castBarButtonItem.tintColor = .label
        
        return [castBarButtonItem, searchBarButtonItem]
    }()
    
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return HomeViewController.createSectionLayout(section: sectionIndex)})
        
        collectionView.register(HeaderMovieItemViewCell.self, forCellWithReuseIdentifier: HeaderMovieItemViewCell.identifier)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.register(HomeViewHeaderCollectionResuableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeViewHeaderCollectionResuableView.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // MARK: Properties
    
    var presenter: AnyPresenter?
    
    private var sections = [HomeItemSectionType]()
    
    // MARK: Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewAppearance()
        initializeSubviews()
        setupCollectionViews()
        
        fetchData()
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
    
    private func fetchData() {
        configureCellData()
    }
    
    private func configureCellData() {
        sections.append(.carousel)
        sections.append(.new)
        sections.append(.recommended)
    }
    
    @objc
    private func searchBarButtonItemPressed() {}
    
    @objc
    private func castBarButtonItemPressed() {}
}

// MARK: Appearance

extension HomeViewController {
    
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
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UICollectionView Delegate & DataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = self.sections[indexPath.section]
        
        switch type {
        case .carousel:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderMovieItemViewCell.identifier, for: indexPath) as? HeaderMovieItemViewCell else {
                return UICollectionViewCell()
            }
            cell.configureViewData(title: "Hello World!", image: UIImage(named: "hero-image")!)
            return cell
        case .new:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderMovieItemViewCell.identifier, for: indexPath) as? HeaderMovieItemViewCell else {
                return UICollectionViewCell()
            }
            cell.configureViewData(title: "Hello World!", image: UIImage(named: "hero-image")!)
            return cell
        case .recommended:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderMovieItemViewCell.identifier, for: indexPath) as? HeaderMovieItemViewCell else {
                return UICollectionViewCell()
            }
            cell.configureViewData(title: "Hello World!", image: UIImage(named: "hero-image")!)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeViewHeaderCollectionResuableView.identifier, for: indexPath) as? HomeViewHeaderCollectionResuableView else {
            return UICollectionReusableView()
        }
        return headerView
    }
    
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(320),
                    heightDimension: .absolute(225)
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

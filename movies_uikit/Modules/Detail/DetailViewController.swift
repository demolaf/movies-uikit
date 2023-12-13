//
//  DetailViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import UIKit

protocol DetailView: AnyObject {
    var presenter: DetailPresenter? { get set }

    func update(recommendedMovies: [Show])
    func update(recommendedTVShows: [Show])
}

class DetailViewController: UIViewController, DetailView {

    private let rootView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let rootScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let rootScrollStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.cornerRadius = 24
        stackView.backgroundColor = .systemBackground
        stackView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        // without this causes the imageview to bleed out of the frame
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let detailHeaderView: DetailHeaderView = {
        let headerView = DetailHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    private let detailDescriptionView: DetailDescriptionView = {
        let descriptionView = DetailDescriptionView()
        return descriptionView
    }()

    private let recommendationsBasedOnItemView: RecommendedBasedOnItemView = {
        let view = RecommendedBasedOnItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 1
        ).isActive = true
        return view
    }()

    var presenter: DetailPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground

        initializeSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        applyConstraints()
    }

    private func initializeSubviews() {
        self.view.addSubview(rootView)
        rootView.addSubview(headerImageView)
        rootView.addSubview(rootScrollView)
        rootScrollView.addSubview(rootScrollStackView)
        rootScrollStackView.addArrangedSubview(detailHeaderView)
        rootScrollStackView.addArrangedSubview(detailDescriptionView)
        rootScrollStackView.addArrangedSubview(recommendationsBasedOnItemView)
    }

    func initializeViewData(show: Show) {
        if let backdropPath = show.backdropPath {
            self.headerImageView.sd_setImage(
                with: HTTPConstants.Endpoints.posterPath(
                    url: backdropPath,
                    quality: "original"
                ).url
            )
        }
        detailHeaderView.configureViewData(show: show)
        detailDescriptionView.configureViewData(show: show)
        presenter?.getRecommendedMovies(id: String(show.id))
        detailHeaderView.saveForLaterPressedCallback = {
            self.presenter?.bookmarkButtonPressed(show: show)
        }
        recommendationsBasedOnItemView.viewAllItemsCallback = { items in
            self.presenter?.viewAllButtonTapped(
                sectionTitle: "Related to \(show.title)",
                items: items
            )
        }
        recommendationsBasedOnItemView.itemSelectedCallback = { item in
            self.presenter?.recommendedItemTapped(item: item)
        }
    }

    func update(recommendedMovies: [Show]) {
        recommendationsBasedOnItemView.configureViewItems(items: recommendedMovies)
    }

    func update(recommendedTVShows: [Show]) {
        recommendationsBasedOnItemView.configureViewItems(items: recommendedTVShows)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
                //
                rootView.topAnchor.constraint(equalTo: view.topAnchor),
                rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                headerImageView.topAnchor.constraint(equalTo: rootView.topAnchor),
                headerImageView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
                headerImageView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
                headerImageView.heightAnchor.constraint(equalTo: rootView.heightAnchor, multiplier: 0.5),

                //
                rootScrollView.topAnchor.constraint(equalTo: rootView.topAnchor),
                rootScrollView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
                rootScrollView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
                rootScrollView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),

                //
                rootScrollStackView.topAnchor.constraint(
                    equalTo: self.rootScrollView.contentLayoutGuide.topAnchor,
                    constant: 300
                ),
                rootScrollStackView.leadingAnchor.constraint(
                    equalTo: self.rootScrollView.contentLayoutGuide.leadingAnchor
                ),
                rootScrollStackView.trailingAnchor.constraint(
                    equalTo: self.rootScrollView.contentLayoutGuide.trailingAnchor
                ),
                rootScrollStackView.bottomAnchor.constraint(
                    equalTo: self.rootScrollView.contentLayoutGuide.bottomAnchor
                ),
                rootScrollStackView.widthAnchor.constraint(
                    equalTo: self.rootScrollView.frameLayoutGuide.widthAnchor
                )
            ])
    }
}

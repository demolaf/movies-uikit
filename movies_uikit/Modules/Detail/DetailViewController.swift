//
//  DetailViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import UIKit

protocol DetailView: AnyObject {
    var presenter: DetailPresenter? { get set }

    func update(recommendedMovies: [Movie])
    func update(recommendedTVShows: [TVShow])
}

class DetailViewController: UIViewController, DetailView {

    private let rootScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let rootScrollStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let detailHeaderView: DetailHeaderView = {
        let headerView = DetailHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(
            equalTo: headerView.widthAnchor,
            multiplier: 1.5
        ).isActive = true
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
        self.view.addSubview(rootScrollView)
        rootScrollView.addSubview(rootScrollStackView)

        rootScrollStackView.addArrangedSubview(detailHeaderView)
        rootScrollStackView.addArrangedSubview(detailDescriptionView)
        rootScrollStackView.addArrangedSubview(recommendationsBasedOnItemView)
    }

    func initializeViewData(movie: Movie?, tvShow: TVShow?) {
        // TODO: Check if movie or tvShow is in db for "saveForLater" button
        if let movie = movie {
            // self.title = movie.originalTitle
            detailHeaderView.configureViewData(movie: movie)
            detailDescriptionView.configureViewData(movie: movie)
            presenter?.getRecommendedMovies(id: String(movie.movieId))
            detailHeaderView.saveForLaterPressedCallback = {
                self.presenter?.bookmarkButtonPressed(movie: movie)
            }
        }

        if let tvShow = tvShow {
            // self.title = tvShow.originalName
            detailHeaderView.configureViewData(tvShow: tvShow)
            detailDescriptionView.configureViewData(tvShow: tvShow)
            presenter?.getRecommendedTVShows(id: String(tvShow.tvShowId))
            detailHeaderView.saveForLaterPressedCallback = {
                self.presenter?.bookmarkButtonPressed(tvShow: tvShow)
            }
        }

        recommendationsBasedOnItemView.itemSelectedCallback = { item in
            self.presenter?.recommendedItemTapped(item: item)
        }
    }

    func update(recommendedMovies: [Movie]) {
        recommendationsBasedOnItemView.configureViewItems(items: recommendedMovies)
    }

    func update(recommendedTVShows: [TVShow]) {
        recommendationsBasedOnItemView.configureViewItems(items: recommendedTVShows)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            //
            rootScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            rootScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            rootScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            rootScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            //
            rootScrollStackView.topAnchor.constraint(
                equalTo: self.rootScrollView.contentLayoutGuide.topAnchor
            ),
            rootScrollStackView.leadingAnchor.constraint(
                equalTo: self.rootScrollView.contentLayoutGuide.leadingAnchor
            ),
            rootScrollStackView.trailingAnchor.constraint(
                equalTo: self.rootScrollView.contentLayoutGuide.trailingAnchor
            ),
            rootScrollStackView.bottomAnchor.constraint(equalTo: self.rootScrollView.contentLayoutGuide.bottomAnchor),
            rootScrollStackView.widthAnchor.constraint(equalTo: self.rootScrollView.frameLayoutGuide.widthAnchor)
        ])
    }
}

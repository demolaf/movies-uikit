//
//  DetailViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import UIKit

protocol DetailViewDelegate: AnyObject {
    var presenter: DetailPresenterDelegate? { get set }
    func initializeViewData(movie: Movie?, tvShow: TVShow?)
}

class DetailViewController: UIViewController, DetailViewDelegate {

    private let rootScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let rootScrollStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.distribution = .fill
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
        view.heightAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 1
        ).isActive = true
        return view
    }()

    var presenter: DetailPresenterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground

        initializeSubviews()

        presenter?.initialize()
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
        if let movie = movie {
            // self.title = movie.originalTitle
            self.detailHeaderView.configureViewData(movie: movie)
            self.detailDescriptionView.configureViewData(movie: movie)
        }

        if let tvShow = tvShow {
            // self.title = tvShow.originalName
            self.detailHeaderView.configureViewData(tvShow: tvShow)
            self.detailDescriptionView.configureViewData(tvShow: tvShow)
        }
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

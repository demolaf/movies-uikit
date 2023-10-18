//
//  LibraryTabBarView.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 04/09/2023.
//

import UIKit

protocol LibraryTabBarViewDelegate: AnyObject {
    func didTapMovieTabBar()
    func didTapTVTabBar()
}

class LibraryTabBarView: UIView {

    weak var delegate: LibraryTabBarViewDelegate?

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let tabBarView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .bottom
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let tabBarSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.grayscale300
        view.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let moviesTabIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true
        view.widthAnchor.constraint(equalToConstant: 150).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        return view
    }()

    private let tvShowTabIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true
        view.widthAnchor.constraint(equalToConstant: 150).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        return view
    }()

    private let movieSectionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()

    private let tvShowSectionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()

    private let movieSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Movies"
        label.textColor = .label
        label.font = .appFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let tvShowSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "TV Shows"
        label.textColor = .label
        label.font = .appFont(ofSize: 16, weight: .semibold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()

        // Set default tab section to movies
        changeSelectedTab(section: .movies)

        initializeTabBarTapGestureRecognizers()
    }

    required init(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        applyConstraints()
    }

    private func initializeSubviews() {

        self.addSubview(tabBarSeparatorView)
        self.addSubview(stackView)
        self.stackView.addArrangedSubview(tabBarView)

        self.tabBarView.addArrangedSubview(movieSectionStackView)
        self.tabBarView.addArrangedSubview(tvShowSectionStackView)

        movieSectionStackView.addArrangedSubview(movieSectionLabel)
        movieSectionStackView.addArrangedSubview(moviesTabIndicator)

        tvShowSectionStackView.addArrangedSubview(tvShowSectionLabel)
        tvShowSectionStackView.addArrangedSubview(tvShowTabIndicator)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            // Tab Bar Separator View Constraints
            tabBarSeparatorView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor),
            tabBarSeparatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tabBarSeparatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    func changeSelectedTab(section: LibrarySectionType) {
        switch section {
        case .movies:
            UIView.animate(withDuration: 0.2) {
                self.moviesTabIndicator.backgroundColor = .systemRed
                self.tvShowTabIndicator.backgroundColor = .clear

                self.movieSectionLabel.textColor = .systemRed
                self.tvShowSectionLabel.textColor = .label
            }
        case .tvShows:
            UIView.animate(withDuration: 0.2) {
                self.tvShowTabIndicator.backgroundColor = .systemRed
                self.moviesTabIndicator.backgroundColor = .clear

                self.tvShowSectionLabel.textColor = .systemRed
                self.movieSectionLabel.textColor = .label
            }
        }
    }

    private func initializeTabBarTapGestureRecognizers() {
        movieSectionStackView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(movieTabBarPressed)
            )
        )

        tvShowSectionStackView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(tvTabBarPressed)
            )
        )
    }

    @objc
    private func movieTabBarPressed() {
        delegate?.didTapMovieTabBar()
    }

    @objc
    private func tvTabBarPressed() {
        delegate?.didTapTVTabBar()
    }
}

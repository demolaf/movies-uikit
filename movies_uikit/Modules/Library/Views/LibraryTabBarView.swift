//
//  LibraryTabBarView.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 04/09/2023.
//

import UIKit

class LibraryTabBarView: UIView {

    private let tabBarView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 24
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
        view.backgroundColor = .systemRed
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
        view.backgroundColor = .systemRed
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
        label.textColor = .systemRed
        label.font = .appFont(ofSize: 14, weight: .medium)
        return label
    }()

    private let tvShowSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "TV Shows"
        label.font = .appFont(ofSize: 14, weight: .medium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
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
        self.addSubview(tabBarView)

        self.tabBarView.addArrangedSubview(movieSectionStackView)
        self.tabBarView.addArrangedSubview(tvShowSectionStackView)

        movieSectionStackView.addArrangedSubview(movieSectionLabel)
        movieSectionStackView.addArrangedSubview(moviesTabIndicator)

        tvShowSectionStackView.addArrangedSubview(tvShowSectionLabel)
        tvShowSectionStackView.addArrangedSubview(tvShowTabIndicator)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            tabBarView.topAnchor.constraint(equalTo: self.topAnchor),
            tabBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            // Tab Bar Separator View Constraints
            tabBarSeparatorView.topAnchor.constraint(equalTo: self.tabBarView.bottomAnchor),
            tabBarSeparatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tabBarSeparatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

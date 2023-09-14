//
//  DetailDescriptionView.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 05/09/2023.
//

import UIKit

class DetailDescriptionView: UIView {

    private let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .appFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("See More", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.sizeToFit()
        button.backgroundColor = .clear
        return button
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.grayscale300
        view.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        self.addSubview(rootStackView)
        rootStackView.addArrangedSubview(descriptionLabel)
        rootStackView.addArrangedSubview(separator)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func configureViewData(movie: Movie?) {
        if let movie = movie {
            self.descriptionLabel.text = movie.overview
        }
    }

    func configureViewData(tvShow: TVShow?) {
        if let tvShow = tvShow {
            self.descriptionLabel.text = tvShow.overview
        }
    }
}

//
//  DetailHeaderView.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 04/09/2023.
//

import UIKit

class DetailHeaderView: UIView {

    private let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()

    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private let subTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Marvel's Avengers: Infinity War, Only the beginning"
        label.font = .appFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()

    private let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Action & Adventure"
        label.textColor = .lightGray
        label.font = .appFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 1
        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2018, 148 mins"
        label.textColor = .lightGray
        label.font = .appFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        return label
    }()

    private let watchNowButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 6
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true

        // Set attributed string for button
        let title = "Watch Now"
        let titleRange = title.range(of: title)!
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont.appFont(ofSize: 12, weight: .semibold)
            ],
            range: NSRange(titleRange, in: title)
        )
        button.setAttributedTitle(attributedString, for: .normal)

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

    override func layoutSubviews() {
        super.layoutSubviews()

        applyConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func initializeSubviews() {
        self.clipsToBounds = true

        self.addSubview(posterImageView)
        self.addSubview(rootStackView)

        //
        rootStackView.addArrangedSubview(topStackView)
        rootStackView.addArrangedSubview(bottomStackView)
        rootStackView.addArrangedSubview(separator)

        //
        topStackView.addArrangedSubview(titleLabel)

        //
        bottomStackView.addArrangedSubview(subTitleStackView)
        bottomStackView.addArrangedSubview(watchNowButton)

        //
        subTitleStackView.addArrangedSubview(genreLabel)
        subTitleStackView.addArrangedSubview(releaseDateLabel)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            //
            posterImageView.topAnchor.constraint(equalTo: self.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.7),

            //
            rootStackView.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rootStackView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.3)
        ])
    }

    func configureViewData(movie: Movie?) {
        if let movie = movie {
            self.titleLabel.text = movie.originalTitle
            self.releaseDateLabel.text = movie.releaseDate
            self.posterImageView.sd_setImage(
                with: HTTPConstants.Endpoints.posterPath(
                    url: movie.backdropPath,
                    quality: "original"
                ).url
            )
        }
    }

    func configureViewData(tvShow: TVShow?) {
        if let tvShow = tvShow {
            self.titleLabel.text = tvShow.originalName
            self.releaseDateLabel.text = tvShow.firstAirDate
            self.posterImageView.sd_setImage(
                with: HTTPConstants.Endpoints.posterPath(
                    url: tvShow.backdropPath,
                    quality: "original"
                ).url
            )
        }
    }
}

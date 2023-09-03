//
//  HeaderMovieItemView.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit
import SDWebImage

class PopularShowsItemViewCell: UICollectionViewCell {
    static let reuseId = "PopularShowsItemViewCell"

    // MARK: Views

    private let headerMovieItemStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let subtitleStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = 24
        stack.distribution = .equalSpacing
        return stack
    }()

    private let titleLabelView: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()

    private let ratingLabelView: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.sizeToFit()
        return label
    }()

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        initializeSubViews()
        setupCellAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.titleLabelView.text = ""
        self.ratingLabelView.text = ""
        self.imageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        applyConstraints()
    }

    // MARK: Private Methods

    private func initializeSubViews() {
        subtitleStackView.addArrangedSubview(titleLabelView)
        subtitleStackView.addArrangedSubview(ratingLabelView)

        headerMovieItemStackView.addArrangedSubview(imageView)
        headerMovieItemStackView.addArrangedSubview(subtitleStackView)

        addSubview(headerMovieItemStackView)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            headerMovieItemStackView.topAnchor.constraint(equalTo: self.topAnchor),
            headerMovieItemStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerMovieItemStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerMovieItemStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func setupCellAppearance() {}

    // MARK: Public Methods

    func configureViewData(movie: Movie?) {
        if let movie = movie {
            self.titleLabelView.text = movie.originalTitle
            self.ratingLabelView.text = "\(movie.voteAverage)/10"
            self.imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath)")!)
            return
        }

        self.titleLabelView.text = "N/A"
        self.ratingLabelView.text = "0/10"
        self.imageView.image = UIImage(systemName: "photo")
    }
}

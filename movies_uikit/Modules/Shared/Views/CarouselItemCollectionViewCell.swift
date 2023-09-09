//
//  CarouselItemCollectionViewCell.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit
import SDWebImage

class CarouselItemCollectionViewCell: UICollectionViewCell {
    static let reuseId = "CarouselItemCollectionViewCell"

    // MARK: Views

    private let rootStackView: UIStackView = {
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
        stack.alignment = .top
        stack.distribution = .fill
        return stack
    }()

    private let titleLabelView: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .appFont(ofSize: 16, weight: .regular)
        label.sizeToFit()
        label.numberOfLines = 2
        return label
    }()

    private let ratingLabelView: UILabel = {
        let label = UILabel()
        label.font = .appFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .right
        label.sizeToFit()
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
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

        self.titleLabelView.text = nil
        self.ratingLabelView.text = nil
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

        rootStackView.addArrangedSubview(imageView)
        rootStackView.addArrangedSubview(subtitleStackView)

        self.contentView.addSubview(rootStackView)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(
                equalTo: self.contentView.topAnchor
            ),
            rootStackView.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor
            ),
            rootStackView.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor
            ),
            rootStackView.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor
            ),
            imageView.heightAnchor.constraint(
                equalToConstant: self.contentView.frame.height * 0.7
            ),
            titleLabelView.widthAnchor.constraint(
                equalToConstant: self.contentView.frame.width * 0.8
            ),
            ratingLabelView.widthAnchor.constraint(
                equalToConstant: self.contentView.frame.width * 0.2
            )
        ])
    }

    private func setupCellAppearance() {
//        imageView.layer.shadowOpacity = 0.75
//        imageView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        imageView.layer.shadowRadius = 3.0
//        imageView.layer.isGeometryFlipped = false
    }

    // MARK: Public Methods

    func configureViewData(movie: Movie?) {
        if let movie = movie {
            self.titleLabelView.text = movie.originalTitle
            self.ratingLabelView.text = "\(movie.voteAverage)/10"
            self.imageView.sd_setImage(
                with: HTTPConstants.Endpoints.posterPath(
                    url: movie.posterPath,
                    quality: nil
                ).url
            )
            return
        }

        self.titleLabelView.text = "N/A"
        self.ratingLabelView.text = "0/10"
        self.imageView.image = UIImage(systemName: "photo")
    }

    func configureViewData(tv: TVShow?) {
        if let tv = tv {
            self.titleLabelView.text = tv.originalName
            self.ratingLabelView.text = "\(tv.voteAverage)/10"
            self.imageView.sd_setImage(
                with: HTTPConstants.Endpoints.posterPath(
                    url: tv.posterPath,
                    quality: nil
                ).url
            )
            return
        }

        self.titleLabelView.text = "N/A"
        self.ratingLabelView.text = "0/10"
        self.imageView.image = UIImage(systemName: "photo")
    }
}

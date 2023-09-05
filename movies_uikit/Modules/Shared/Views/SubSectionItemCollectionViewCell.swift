//
//  SubSectionItemCollectionViewCell.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import UIKit

class SubSectionItemCollectionViewCell: UICollectionViewCell {
    static let reuseId = "SubSectionItemCollectionViewCell"

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

    private let titleLabelView: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .appFont(ofSize: 14, weight: .regular)
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        self.imageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        applyConstraints()
    }

    // MARK: Private Methods

    private func initializeSubViews() {
        rootStackView.addArrangedSubview(imageView)
        rootStackView.addArrangedSubview(titleLabelView)

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
            self.imageView.sd_setImage(
                with: HTTPConstants.Endpoints.posterPath(
                    url: movie.posterPath,
                    quality: nil
                ).url
            )
            return
        }

        self.titleLabelView.text = "N/A"
        self.imageView.image = UIImage(systemName: "photo")
    }

    func configureViewData(tv: TVShow?) {
        if let tv = tv {
            self.titleLabelView.text = tv.originalName
            self.imageView.sd_setImage(
                with: HTTPConstants.Endpoints.posterPath(
                    url: tv.posterPath,
                    quality: nil
                ).url
            )
            return
        }

        self.titleLabelView.text = "N/A"
        self.imageView.image = UIImage(systemName: "photo")
    }
}

//
//  NewAndRecommendedCollectionViewCell.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import UIKit

class NewAndRecommendedCollectionViewCell: UICollectionViewCell {
    static let reuseId = "NewAndRecommendedCollectionViewCell"

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

    private let titleLabelView: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.sizeToFit()
        label.numberOfLines = 0
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
        self.imageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        applyConstraints()
    }

    // MARK: Private Methods

    private func initializeSubViews() {
        headerMovieItemStackView.addArrangedSubview(imageView)
        headerMovieItemStackView.addArrangedSubview(titleLabelView)

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
            self.imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath)")!)
            return
        }

        self.titleLabelView.text = "N/A"
        self.imageView.image = UIImage(systemName: "photo")
    }
}

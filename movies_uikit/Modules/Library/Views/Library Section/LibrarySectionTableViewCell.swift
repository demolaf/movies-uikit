//
//  LibrarySectionTableViewCell.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 04/09/2023.
//

import UIKit

class LibrarySectionTableViewCell: UITableViewCell {
    static let reuseId = "LibrarySectionTableViewCell"

    private let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        return stackView
    }()

    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let itemTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .appFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()

    private let itemSubtitle: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .appFont(ofSize: 14, weight: .regular)
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

    private let bookmarkButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private let optionsButton: UIButton = {
        let button = UIButton()
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initializeSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        itemImageView.image = nil
        itemTitle.text = nil
        itemSubtitle.text = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        applyConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func initializeSubViews() {
        self.contentView.addSubview(rootStackView)
        rootStackView.addArrangedSubview(itemImageView)
        rootStackView.addArrangedSubview(contentStackView)
        contentStackView.addArrangedSubview(itemTitle)
        contentStackView.addArrangedSubview(itemSubtitle)
        contentStackView.addArrangedSubview(watchNowButton)
    }

    private func applyConstraints() {
        self.contentView.clipsToBounds = true

      NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24),
            rootStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            rootStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            rootStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -24),
            itemImageView.widthAnchor.constraint(
                equalToConstant: self.contentView.frame.width * 0.3
            )
        ])
    }

    private func initializeCellAppearance() {}

    func configureViewData(movie: Movie?) {
        if let movie = movie {
            itemImageView.sd_setImage(
                with: HTTPConstants.Endpoints.posterPath(
                url: movie.posterPath,
                quality: nil
                ).url
            )
            itemTitle.text = movie.originalTitle
            itemSubtitle.text = "\(movie.releaseDate)"
            return
        }

        itemImageView.image = UIImage(named: "hero-image")!
        itemTitle.text = "N/A"
        itemSubtitle.text = "N/A"
    }

    func configureViewData(tv: TVShow?) {
        if let tv = tv {
            itemImageView.sd_setImage(
                with: HTTPConstants.Endpoints.posterPath(
                url: tv.posterPath,
                quality: nil
                ).url
            )
            itemTitle.text = tv.originalName
            itemSubtitle.text = "\(tv.firstAirDate)"
            return
        }

        itemImageView.image = UIImage(systemName: "photo")!
        itemTitle.text = "N/A"
        itemSubtitle.text = "N/A"
    }
}

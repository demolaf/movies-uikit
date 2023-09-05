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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = .blue
        return stackView
    }()
    
    private let subTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let itemTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Marvel's Avengers: Infinity War"
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

    override init(frame: CGRect) {
        super.init(frame: frame)

        initializeSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func initializeSubviews() {
        self.addSubview(itemImageView)
        self.addSubview(rootStackView)

        //
        rootStackView.addArrangedSubview(topStackView)
        rootStackView.addArrangedSubview(bottomStackView)

        //
        topStackView.addArrangedSubview(itemTitle)
        
        //
        bottomStackView.addArrangedSubview(subTitleStackView)
        bottomStackView.addArrangedSubview(watchNowButton)
        
        //
        subTitleStackView.addArrangedSubview(genreLabel)
        subTitleStackView.addArrangedSubview(releaseDateLabel)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: self.topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            itemImageView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.65),
            rootStackView.topAnchor.constraint(equalTo: self.itemImageView.bottomAnchor, constant: 24),
            rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
//            rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }

    func configureViewData(movie: Movie?) {
        if let movie = movie {
            self.itemImageView.sd_setImage(
                with: HTTPConstants.Endpoints.posterPath(
                    url: movie.backdropPath,
                    quality: "original"
                ).url
            )
        }
    }
}

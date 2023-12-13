//
//  DetailDescriptionView.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 05/09/2023.
//

import UIKit
import RxSwift

class DetailDescriptionView: UIView {

    private let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
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

    private lazy var seeMoreButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("See More", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.sizeToFit()
        button.configuration = .plain()
        button.configuration?.contentInsets = .zero
        button.backgroundColor = .clear
        button.addAction(
            UIAction(handler: {[weak self] _ in
                if self?.descriptionLabel.numberOfLines != 0 {
                    self?.descriptionLabel.numberOfLines = 0
                    button.setTitle("See Less", for: .normal)
                } else {
                    self?.descriptionLabel.numberOfLines = 3
                    button.setTitle("See More", for: .normal)
                }

            }),
            for: .primaryActionTriggered
        )
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
        self.addSubview(separator)
        rootStackView.addArrangedSubview(descriptionLabel)
        rootStackView.addArrangedSubview(seeMoreButton)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: self.separator.topAnchor, constant: -24),
            //
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func configureViewData(show: Show?) {
        if let show = show {
            self.descriptionLabel.text = show.overview
            if show.overview.count > 100 {
                self.descriptionLabel.numberOfLines = 3
                seeMoreButton.isHidden = false
            } else {
                self.descriptionLabel.numberOfLines = 0
                seeMoreButton.isHidden = true
            }
        }
    }
}

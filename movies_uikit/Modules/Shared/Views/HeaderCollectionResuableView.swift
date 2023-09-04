//
//  HeaderCollectionResuableView.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import UIKit

class HeaderCollectionResuableView: UICollectionReusableView {
    static let reuseId = "HeaderCollectionResuableView"

    private let leadingTextLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.font = .appFont(ofSize: 18, weight: .semibold)
        label.sizeToFit()
        return label
    }()

    private let trailingButton: UIButton = {
        let button = UIButton()
        let attribute = AttributedString()
        button.setTitle("View all", for: .normal)
        // attribute.font = .appFont(ofSize: 14, weight: .medium)
        button.configuration?.attributedTitle = attribute
        button.setTitleColor(.systemRed, for: .normal)
        button.sizeToFit()
        button.backgroundColor = .clear
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    // MARK: Private Methods

    private func initializeSubViews() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(leadingTextLabel)
        stackView.addArrangedSubview(trailingButton)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func configureHeaderLeadingText(leadingText: String) {
        leadingTextLabel.text = leadingText
    }
}

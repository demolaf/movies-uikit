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
        button.setTitle("View all", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.sizeToFit()
        button.backgroundColor = .clear
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 24)
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
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func configureHeaderLeadingText(leadingText: String) {
        leadingTextLabel.text = leadingText
    }
}

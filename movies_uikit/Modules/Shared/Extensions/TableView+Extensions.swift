//
//  TableView+Extensions.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 18/10/2023.
//

import Foundation
import UIKit

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let titleLabel = UILabel()
        let messageLabel = UILabel()

        titleLabel.textColor = .label
        messageLabel.textColor = .secondaryLabel

        titleLabel.textAlignment = .center
        messageLabel.textAlignment = .center

        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        messageLabel.font = .systemFont(ofSize: 17)

        titleLabel.text = title
        messageLabel.text = message

        messageLabel.numberOfLines = 0

        let emptyView = UIView()

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis  = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 12.0

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)

        emptyView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(
                equalTo: emptyView.centerXAnchor
            ),
            stackView.centerYAnchor.constraint(
                equalTo: emptyView.centerYAnchor
            ),
            stackView.leadingAnchor.constraint(
                equalTo: emptyView.leadingAnchor,
                constant: 20
            ),
            stackView.trailingAnchor.constraint(
                equalTo: emptyView.trailingAnchor,
                constant: -20
            )
        ])

        self.backgroundView = emptyView
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

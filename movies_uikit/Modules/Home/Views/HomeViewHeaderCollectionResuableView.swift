//
//  HomeViewHeaderCollectionResuableView.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import Foundation
import UIKit

class HomeViewHeaderCollectionResuableView: UICollectionReusableView {
    static let identifier = "HomeViewHeaderCollectionResuableView"
    
    private let leadingTextLabel: UILabel = {
       let label = UILabel()
        label.text = "What's new!"
        label.textColor = .label
        label.sizeToFit()
        return label
    }()
    
    private let trailingTextLabel: UILabel = {
       let label = UILabel()
        label.text = "View all"
        label.textColor = .label
        label.sizeToFit()
        return label
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
        stackView.addArrangedSubview(trailingTextLabel)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

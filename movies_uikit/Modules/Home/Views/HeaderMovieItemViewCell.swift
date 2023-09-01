//
//  HeaderMovieItemView.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

class HeaderMovieItemViewCell: UICollectionViewCell {
    static let identifier = "HeaderMovieItemViewCell"
    
    // MARK: Views
    
    private let headerMovieItemStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let subtitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let titleLabelView: UILabel = {
        let labelView = UILabel()
        labelView.textColor = .label
        labelView.sizeToFit()
        return labelView
    }()
    
    private let ratingLabelView: UILabel = {
       let labelView = UILabel()
        labelView.textColor = .label
        labelView.sizeToFit()
        return labelView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyConstraints()
    }
    
    // MARK: Private Methods
    
    private func initializeSubViews() {
        subtitleStackView.addArrangedSubview(titleLabelView)
        subtitleStackView.addArrangedSubview(ratingLabelView)
        
        headerMovieItemStackView.addArrangedSubview(imageView)
        headerMovieItemStackView.addArrangedSubview(subtitleStackView)
        
        addSubview(headerMovieItemStackView)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            headerMovieItemStackView.topAnchor.constraint(equalTo: self.topAnchor),
            headerMovieItemStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerMovieItemStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerMovieItemStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func setupCellAppearance() {}
    
    // MARK: Public Methods
    
    func configureViewData(title: String, image: UIImage) {
        self.titleLabelView.text = title
        self.ratingLabelView.text = "90%"
        self.imageView.image = image
    }
}

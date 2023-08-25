//
//  HeaderMovieItemView.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

class HeaderMovieItemView: UIView {
    
    private let movieItemStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabelView: UILabel = {
        let labelView = UILabel()
        return labelView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //
        initializeSubViews()
        
        //
        buildView()
    }
    
    func initializeSubViews() {
        movieItemStackView.addArrangedSubview(imageView)
        movieItemStackView.addArrangedSubview(titleLabelView)
        
        addSubview(movieItemStackView)
    }
    
    func buildView() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

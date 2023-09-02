//
//  LeadingBarButtonItem.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 26/08/2023.
//

import Foundation
import UIKit

class LeadingBarButtonItem: UIBarButtonItem {

    let leadingIcon: UIImageView = {
        let drawerIcon = UIImageView(image: UIImage(systemName: "ellipsis"))
        drawerIcon.tintColor = .label
        return drawerIcon
    }()

    let navBarTitle: UILabel = {
        //
        let navBarTitle = UILabel()

        //
        let firstText = "Play"
        let secondText = "Movies"

        //
        let title = "\(firstText) \(secondText)"
        let firstTextRange = title.range(of: firstText)!
        let secondTextRange = title.range(of: secondText)!

        //
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.label, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .regular)], range: NSRange(firstTextRange, in: title))
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .regular)], range: NSRange(secondTextRange, in: title))
        navBarTitle.attributedText = attributedString

        return navBarTitle
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init() {
        super.init()
        setupView()
    }

    func setupView() {
        stackView.addArrangedSubview(leadingIcon)
        stackView.addArrangedSubview(navBarTitle)

        self.customView = stackView
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

//
//  TVShowsBarButtonItem.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import UIKit

class TVShowsBarButtonItem: UIBarButtonItem {
    private let navBarTitle: UILabel = {
        let navBarTitle = UILabel()
        navBarTitle.text = "TV Shows"
        navBarTitle.font = .systemFont(ofSize: 32, weight: .bold)
        navBarTitle.translatesAutoresizingMaskIntoConstraints = false
        return navBarTitle
    }()

    override init() {
        super.init()

        self.customView = navBarTitle
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

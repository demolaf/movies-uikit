//
//  LibraryBarButtonItem.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 04/09/2023.
//

import UIKit

class LibraryBarButtonItem: UIBarButtonItem {
    private let navBarTitle: UILabel = {
        let navBarTitle = UILabel()
        navBarTitle.text = "Library"
        navBarTitle.font = .appFont(ofSize: 32, weight: .bold)
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

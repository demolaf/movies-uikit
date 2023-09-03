//
//  LibraryViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import UIKit

protocol LibraryViewDelegate: AnyView, AnyObject {
    func update(with movies: [Movie])
}

class LibraryViewController: UIViewController, LibraryViewDelegate {

    var presenter: AnyPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
    }

    func update(with movies: [Movie]) {

    }
}

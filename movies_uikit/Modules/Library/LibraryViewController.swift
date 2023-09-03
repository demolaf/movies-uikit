//
//  LibraryViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import UIKit

protocol LibraryViewDelegate: AnyObject {
    var presenter: LibraryPresenterDelegate? { get set }

    func update(with movies: [Movie])
}

class LibraryViewController: UIViewController, LibraryViewDelegate {

    var presenter: LibraryPresenterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground

        presenter?.initialize()
    }

    func update(with movies: [Movie]) {

    }
}

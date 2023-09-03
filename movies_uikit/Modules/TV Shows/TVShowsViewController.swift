//
//  TVShowsViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import UIKit

protocol TVShowsViewDelegate: AnyView, AnyObject {
    func update(with movies: [Movie])
}

class TVShowsViewController: UIViewController, TVShowsViewDelegate {

    var presenter: AnyPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func update(with movies: [Movie]) {

    }
}

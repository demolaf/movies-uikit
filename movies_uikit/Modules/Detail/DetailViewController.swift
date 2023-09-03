//
//  DetailViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import UIKit

protocol DetailViewDelegate: AnyView, AnyObject {
    func update(with movies: [Movie])
}

class DetailViewController: UIViewController, DetailViewDelegate {

    var presenter: AnyPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func update(with movies: [Movie]) {

    }
}

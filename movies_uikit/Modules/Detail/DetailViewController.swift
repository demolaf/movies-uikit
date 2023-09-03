//
//  DetailViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import UIKit

protocol DetailViewDelegate: AnyObject {
    var presenter: DetailPresenterDelegate? { get set }

    func update(with movies: [Movie])
}

class DetailViewController: UIViewController, DetailViewDelegate {

    var presenter: DetailPresenterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter?.initialize()
    }

    func update(with movies: [Movie]) {

    }
}

//
//  HomeViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol HomeViewDelegate: AnyView {
    // func update(with users: [User])
    // func update(with error: String)
}

class HomeViewController: UIViewController, HomeViewDelegate {
    var presenter: AnyPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
    }
}

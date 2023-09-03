//
//  LaunchViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol LaunchViewDelegate: AnyView, AnyObject {}

class LaunchViewController: UIViewController, LaunchViewDelegate {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading application, please wait..."
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    var presenter: AnyPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)

        view.backgroundColor = .gray
        view.addSubview(titleLabel)

        titleLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 150)
        titleLabel.center = view.center

        (presenter as? LaunchPresenter)?.initialize()
    }
}

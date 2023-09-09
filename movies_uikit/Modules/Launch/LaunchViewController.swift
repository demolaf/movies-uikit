//
//  LaunchViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit
import RiveRuntime

protocol LaunchView: AnyObject {
    var presenter: LaunchPresenter? { get set }
}

class LaunchViewController: UIViewController, LaunchView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading application, please wait..."
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .appFont(ofSize: 20)
        return label
    }()

    private let loadingAnimationView: RiveView = {
        let riveVM = RiveViewModel(
            fileName: "sith-de-mayo",
            stateMachineName: "State Machine 1",
            artboardName: "New Artboard"
        )

        return riveVM.createRiveView()
    }()

    var presenter: LaunchPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)

        view.backgroundColor = .systemBackground

        initializeSubviews()

        presenter?.initialize()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        applyConstraints()
    }

    private func initializeSubviews() {
        view.addSubview(titleLabel)
        // view.addSubview(loadingAnimationView)
    }

    private func applyConstraints() {
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 150)
        titleLabel.center = view.center

        // loadingAnimationView.frame = view.bounds
    }
}

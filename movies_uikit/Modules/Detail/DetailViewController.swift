//
//  DetailViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 02/09/2023.
//

import UIKit

protocol DetailViewDelegate: AnyObject {
    var presenter: DetailPresenterDelegate? { get set }
    var movie: Movie? { get set }
}

class DetailViewController: UIViewController, DetailViewDelegate {
    
    private let rootScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let rootScrollStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let detailHeaderView: DetailHeaderView = {
        let headerView = DetailHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    var movie: Movie?

    var presenter: DetailPresenterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground

        initializeSubviews()
        initializeViewData()

        presenter?.initialize()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        applyConstraints()
    }

    private func initializeSubviews() {
        let placeholderPleaseRemove = UIView()
        placeholderPleaseRemove.translatesAutoresizingMaskIntoConstraints = false
        placeholderPleaseRemove.heightAnchor.constraint(equalToConstant: 2000).isActive = true
        
        self.view.addSubview(rootScrollView)
        rootScrollView.addSubview(rootScrollStackView)
        rootScrollStackView.addArrangedSubview(detailHeaderView)
        rootScrollStackView.addArrangedSubview(placeholderPleaseRemove)
    }
    
    private func initializeViewData() {
        self.detailHeaderView.configureViewData(movie: movie)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            //
            rootScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            rootScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            rootScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            rootScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            //
            rootScrollStackView.topAnchor.constraint(equalTo: self.rootScrollView.contentLayoutGuide.topAnchor),
            rootScrollStackView.leadingAnchor.constraint(equalTo: self.rootScrollView.contentLayoutGuide.leadingAnchor),
            rootScrollStackView.trailingAnchor.constraint(equalTo: self.rootScrollView.contentLayoutGuide.trailingAnchor),
            rootScrollStackView.bottomAnchor.constraint(equalTo: self.rootScrollView.contentLayoutGuide.bottomAnchor),
            rootScrollStackView.widthAnchor.constraint(equalTo: self.rootScrollView.frameLayoutGuide.widthAnchor),

            //
            detailHeaderView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.6)
        ])
    }
}

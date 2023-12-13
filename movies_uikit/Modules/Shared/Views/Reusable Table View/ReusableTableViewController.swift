//
//  ReusableTableViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import UIKit
import RxSwift
import RxCocoa

protocol ReusableTableViewControllerDelegate: AnyObject {
    func didTapItem(item: Show)
}

class ReusableTableViewController: UIViewController, UITableViewDelegate {
    private var loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            ReusableTableViewCell.self,
            forCellReuseIdentifier: ReusableTableViewCell.reuseId
        )
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        return tableView
    }()

    var items = BehaviorRelay<[Show]>(value: [])

    private let bag = DisposeBag()

    var delegate: ReusableTableViewControllerDelegate?

    private let showLoadingIndicatorSubject = BehaviorSubject<Bool>(value: false)
    var showLoadingIndicator: BehaviorSubject<Bool> {
        return showLoadingIndicatorSubject
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground

        view.addSubview(tableView)
        view.addSubview(loadingIndicator)

        bindLoadingIndicator()
        bindTableView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = self.view.bounds
        loadingIndicator.center = view.center
    }

    private func bindLoadingIndicator() {
        showLoadingIndicatorSubject
            .subscribe { [weak self] loading in
                if loading {
                    self?.tableView.isHidden = true
                    self?.loadingIndicator.startAnimating()
                } else {
                    self?.tableView.isHidden = false
                    self?.loadingIndicator.stopAnimating()
                }
            }
            .disposed(by: bag)
    }

    private func bindTableView() {
        items
            .debug("items in resuable vc")
            .subscribe(onNext: {[weak self] items in
                if items.isEmpty {
                    self?.tableView.setEmptyView(
                        title: "No Items",
                        message: ""
                    )
                } else {
                    self?.tableView.restore()
                }
            })
            .disposed(by: bag)

        // Bind items to table
        items.bind(
            to: tableView.rx.items(
                cellIdentifier: ReusableTableViewCell.reuseId,
                cellType: ReusableTableViewCell.self)
        ) { _, item, cell in
            cell.selectionStyle = .none
            cell.configureViewData(show: item)
        }
        .disposed(by: bag)

        // Bind a model selected handler
        tableView.rx.modelSelected(Show.self).bind { [weak self] item in
            if let delegate = self?.delegate {
                delegate.didTapItem(item: item)
            } else {
                if let detailVC = Routes.detail.vc as? DetailViewController {
                    detailVC.initializeViewData(show: item)
                    detailVC.hidesBottomBarWhenPushed = true
                    self?.navigationController?.pushViewController(detailVC, animated: true)
                }
            }
        }
        .disposed(by: bag)

        tableView
            .rx.setDelegate(self)
            .disposed(by: bag)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
}

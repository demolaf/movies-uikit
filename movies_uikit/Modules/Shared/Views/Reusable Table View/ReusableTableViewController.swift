//
//  ReusableTableViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ReusableTableViewController: UIViewController {

    var items = BehaviorRelay<[AnyObject]>(value: [])

    private var bag = DisposeBag()

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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground

        self.view.addSubview(tableView)

        bindTableData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = self.view.bounds
    }

    private func bindTableData() {
        // Bind items to table
        items.bind(
            to: tableView.rx.items(
                cellIdentifier: ReusableTableViewCell.reuseId,
                cellType: ReusableTableViewCell.self)
        ) { _, item, cell in
            cell.selectionStyle = .none
            if let item = item as? Movie {
                cell.configureViewData(movie: item)
            }

            if let item = item as? TVShow {
                cell.configureViewData(tv: item)
            }
        }.disposed(by: bag)

        // Bind a model selected handler
        tableView.rx.modelSelected(AnyObject.self).bind { item in
            let detailVC = Routes.detail.vc as? DetailViewController
            if let detailVC = detailVC {
                if let item = item as? Movie {
                    detailVC.initializeViewData(movie: item, tvShow: nil)
                }
                if let item = item as? TVShow {
                    detailVC.initializeViewData(movie: nil, tvShow: item)
                }
                detailVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }.disposed(by: bag)

        tableView
            .rx.setDelegate(self)
            .disposed(by: bag)
    }
}

extension ReusableTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
}

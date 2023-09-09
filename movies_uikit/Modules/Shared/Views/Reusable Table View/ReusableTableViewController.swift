//
//  ReusableTableViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import UIKit

class ReusableTableViewController: UIViewController {

    var items = [AnyObject]()

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
        tableView.delegate = self
        tableView.dataSource = self

        self.view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = self.view.bounds
    }
}

extension ReusableTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return items.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReusableTableViewCell.reuseId,
            for: indexPath
        ) as? ReusableTableViewCell else {
            return UITableViewCell()
        }

        cell.selectionStyle = .none

        if let item = items[indexPath.row] as? Movie {
            cell.configureViewData(movie: item)
        }

        if let item = items[indexPath.row] as? TVShow {
            cell.configureViewData(tv: item)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]

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
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
}

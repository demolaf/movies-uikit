//
//  ReusableTableViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import UIKit

class ReusableTableViewController: UIViewController {

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
        return 10
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
        cell.configureViewData(movie: nil)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
}

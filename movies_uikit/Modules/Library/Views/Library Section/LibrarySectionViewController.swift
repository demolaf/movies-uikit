//
//  LibrarySectionViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import UIKit

/// Custom dynamically instantiated view controller for library sections
class LibrarySectionViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            LibrarySectionTableViewCell.self,
            forCellReuseIdentifier: LibrarySectionTableViewCell.reuseId
        )
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true

        tableView.delegate = self
        tableView.dataSource = self

        self.view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = self.view.bounds
    }
}

extension LibrarySectionViewController: UITableViewDelegate, UITableViewDataSource {
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
            withIdentifier: LibrarySectionTableViewCell.reuseId,
            for: indexPath
        ) as? LibrarySectionTableViewCell else {
            return UITableViewCell()
        }

        cell.configureViewData(movie: nil)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
}

//
//  ReposListViewController.swift
//  GitRx
//
//  Created by Михаил Нечаев on 21.12.2019.
//  Copyright © 2019 Михаил Нечаев. All rights reserved.
//

import UIKit

final class ReposListViewController: UIViewController {
    
    // MARK: - Properties
    
    private var contentView = ReposListView()
    private let refresher = UIRefreshControl()
    
    // MARK: - Lifecycle methods
    
    override func loadView() {
        contentView = ReposListView(frame: UIScreen.main.bounds)
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

// MARK: - Setup UI

private extension ReposListViewController {
    
    func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "GitRx"
        setupTableView()
        setupRefresher()
    }
    
    func setupTableView() {
        contentView.reposTableView.delegate = self
        contentView.reposTableView.dataSource = self
        contentView.reposTableView.register(RepoTableViewCell.self, forCellReuseIdentifier: "cell")
        contentView.reposTableView.tableFooterView = UIView(frame: .zero)
        contentView.reposTableView.addSubview(refresher)
    }
    
    func setupRefresher() {
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
}

// MARK: - Actions

@objc
private extension ReposListViewController {
    
    func refresh() {
        refresher.endRefreshing()
    }
    
}

// MARK: - UITableViewDelegate

extension ReposListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - UITableViewDataSource

extension ReposListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RepoTableViewCell else {
            return UITableViewCell()
        }
        //setup cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }

}

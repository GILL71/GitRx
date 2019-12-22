//
//  ReposListViewController.swift
//  GitRx
//
//  Created by Михаил Нечаев on 21.12.2019.
//  Copyright © 2019 Михаил Нечаев. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ReposListViewController: UIViewController {
    
    // MARK: - Properties
    
    private var contentView = ReposListView()
    private let refresher = UIRefreshControl()
    private let viewModel = ReposListViewModel()
    private var repos = PublishSubject<[RepoResponse]>()
    private let disposeBag = DisposeBag()
    private let imageLoader = ImageLoader()

    // MARK: - Lifecycle methods
    
    override func loadView() {
        contentView = ReposListView(frame: UIScreen.main.bounds)
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }
    
}

// MARK: - Binding

private extension ReposListViewController {
    
    func setupBinding() {
        setupTableViewBinding()
        setupRefresherBinding()
        setupReposBinding()
        setupTableViewDelegateBinding()
    }
    
    func setupTableViewDelegateBinding() {
        contentView.reposTableView.rx.setDelegate(self)
        .disposed(by: disposeBag)
    }
    
    func setupReposBinding() {
        viewModel
        .repos
        .observeOn(MainScheduler.instance)
        .bind(to: repos)
        .disposed(by: disposeBag)
    }
    
    func setupRefresherBinding() {
        viewModel.isLoading.bind(to: refresher.rx.isRefreshing)
        .disposed(by: disposeBag)
    }
    
    func setupTableViewBinding() {
        repos.bind(to: contentView.reposTableView.rx.items(cellIdentifier: "cell", cellType: RepoTableViewCell.self)) { [weak self]  (row,repo,cell) in
            cell.nameLabel.text = repo.name
            cell.descriptionLabel.text = repo.description
            cell.languageLabel.text = repo.language ?? "None"
            cell.forksLabel.text = "Forks: \(repo.forksCount)"
            cell.starsLabel.text = "Stars: \(repo.starsCount)"
            cell.dateLabel.text = String(repo.updateDate.prefix(10))
            cell.avatarImageView.image = UIImage(named: "placeholder")
            
            if let avatarURLString = repo.owner.avatarURL {
                self?.imageLoader.load(with: avatarURLString) { (data) in
                    DispatchQueue.main.async {
                        cell.avatarImageView.image = UIImage(data: data)
                    }
                }
            }
            
        }.disposed(by: disposeBag)
    }
    
}

// MARK: - Setup UI

private extension ReposListViewController {
    
    func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "GitRx"
        setupTableView()
        setupRefresher()
        setupSearchBar()
    }
    
    func setupTableView() {
        contentView.reposTableView.register(RepoTableViewCell.self, forCellReuseIdentifier: "cell")
        contentView.reposTableView.tableFooterView = UIView(frame: .zero)
        contentView.reposTableView.refreshControl = refresher
        contentView.reposTableView.estimatedRowHeight = 105
        contentView.reposTableView.rowHeight = UITableView.automaticDimension
    }
    
    func setupSearchBar() {
        contentView.searchBar.delegate = self
    }
    
    func setupRefresher() {
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
}

// MARK: - Actions

@objc
private extension ReposListViewController {
    
    func refresh() {
        search(with: contentView.searchBar.text)
    }
    
}

// MARK: - UISearchBarDelegate

extension ReposListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(with: searchBar.text)
        refresher.endRefreshing()
        searchBar.endEditing(true)
    }
    
}

// MARK: - UITableViewDelegate

extension ReposListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: - Helpers

private extension ReposListViewController {
    
    func search(with text: String?) {
        if let query = text, !query.isEmpty {
            viewModel.search(with: query)
        } else {
            viewModel.repos.onNext([])
        }
    }
    
}

//
//  RepoViewController.swift
//  GitRx
//
//  Created by Михаил Нечаев on 21.12.2019.
//  Copyright © 2019 Михаил Нечаев. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WebKit

final class RepoViewController: UIViewController {
    
    // MARK: - Properties

    private let userName: String
    private let repoName: String
    private let htmlURL: String
    private let viewModel = RepoViewModel()
    private var content = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    private var contentView = RepoView()

    // MARK: - Initializers

    init(with repo: RepoResponse) {
        repoName = repo.name
        userName = repo.owner.userName
        htmlURL = repo.owner.htmlURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func loadView() {
        contentView = RepoView(frame: UIScreen.main.bounds)
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getReadme(for: userName, repo: repoName)
        setupNavigationItem()
        setupBinding()
    }

}

// MARK: - Binding

private extension RepoViewController {
    
    func setupBinding() {
        setupTextViewBinding()
        setupViewModelBinding()
    }
    
    func setupViewModelBinding() {
        viewModel
        .readme
        .observeOn(MainScheduler.instance)
        .bind(to: content)
        .disposed(by: disposeBag)
    }
    
    func setupTextViewBinding() {
        content.bind(to: contentView.textView.rx.text).disposed(by: disposeBag)
    }

}

// MARK: - Setup UI

private extension RepoViewController {

    func setupNavigationItem() {
        navigationItem.title = repoName
        addWebItem()
    }
    
    func addWebItem() {
        let item = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showDoc))
        navigationItem.rightBarButtonItem = item
    }
    
}

// MARK: - Actions

@objc
private extension RepoViewController {

    func showDoc() {
        guard let url = URL(string: htmlURL + "/" + repoName) else { return }
        let webVC = WebViewController(url: url)
        present(webVC, animated: true, completion: nil)
    }
    
}

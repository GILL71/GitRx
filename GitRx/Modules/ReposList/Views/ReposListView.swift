//
//  ReposListView.swift
//  GitRx
//
//  Created by Михаил Нечаев on 21.12.2019.
//  Copyright © 2019 Михаил Нечаев. All rights reserved.
//

import UIKit

final class ReposListView: UIView {
    
    // MARK: - Properties
    
    let searchBar = UISearchBar()
    let reposTableView = UITableView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup UI

private extension ReposListView {
    
    func setupUI() {
        backgroundColor = .white
        setupSearchBarUI()
    }
    
    func setupSearchBarUI() {
        tintColor = .black
        addToolBar()
    }
    
    func addToolBar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        toolBar.tintColor = .black
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [flexibleSpace, doneButton]
        searchBar.inputAccessoryView = toolBar
    }
    
}

// MARK: - Setup layout

private extension ReposListView {
    
    func setupLayout() {
        setupSearchBarLayout()
        setupTalbeViewLayout()
    }
    
    func setupSearchBarLayout() {
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func setupTalbeViewLayout() {
        addSubview(reposTableView)
        reposTableView.translatesAutoresizingMaskIntoConstraints = false
        reposTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        reposTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        reposTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        reposTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}

// MARK: - Actions

@objc
private extension ReposListView {
    
    func donePressed(){
        searchBar.endEditing(true)
    }
    
}

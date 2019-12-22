//
//  RepoView.swift
//  GitRx
//
//  Created by Михаил Нечаев on 23.12.2019.
//  Copyright © 2019 Михаил Нечаев. All rights reserved.
//

import UIKit

final class RepoView: UIView {
    
    let textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        textView.isEditable = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup layout

private extension RepoView {
    
    func setupLayout() {
        backgroundColor = .white
        setupTextViewLayout()
    }
    
    func setupTextViewLayout() {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}

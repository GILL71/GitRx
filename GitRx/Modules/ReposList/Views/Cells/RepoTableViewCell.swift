//
//  RepoTableViewCell.swift
//  GitRx
//
//  Created by Михаил Нечаев on 21.12.2019.
//  Copyright © 2019 Михаил Нечаев. All rights reserved.
//

import UIKit
import RxSwift

final class RepoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .darkText
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .darkText
        return label
    }()
    
    lazy var starsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .darkText
        label.textAlignment = .right
        return label
    }()
    
    lazy var forksLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .darkText
        label.textAlignment = .right
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .darkText
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup layout

private extension RepoTableViewCell {
    
    func setupLayout() {
        setupAvatarLayout()
        setupNameLayout()
        setupDescriptionLayout()
        setupLanguageLayout()
        setupStarsLayout()
        setupForksLayout()
        setupDateLayout()
    }
    
    func setupAvatarLayout() {
        addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func setupNameLayout() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
    }
    
    func setupDescriptionLayout() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6).isActive = true
    }
    
    func setupLanguageLayout() {
        addSubview(languageLabel)
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16).isActive = true
        languageLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6).isActive = true
    }
    
    func setupStarsLayout() {
        addSubview(starsLabel)
        starsLabel.translatesAutoresizingMaskIntoConstraints = false
        starsLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8).isActive = true
        starsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        starsLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 0).isActive = true
    }
    
    func setupForksLayout() {
        addSubview(forksLabel)
        forksLabel.translatesAutoresizingMaskIntoConstraints = false
        forksLabel.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 8).isActive = true
        forksLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        forksLabel.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor, constant: 0).isActive = true
    }
    
    func setupDateLayout() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: languageLabel.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 0).isActive = true
    }

}

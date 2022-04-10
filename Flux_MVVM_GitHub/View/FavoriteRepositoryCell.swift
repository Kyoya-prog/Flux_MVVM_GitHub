//
//  FavoriteRepositoryCell.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/10.
//

import UIKit

final class FavoriteRepositoryCell:UITableViewCell{
    
    static let reuseIdentifier = "favorite-repository-cell"

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        construct()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        construct()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        configure(title: "", description: "", language: "", starCount: 0)
    }
    
    func configure(title:String,description:String,language:String,starCount:Int){
        titleLabel.text = title
        descriptionLabel.text = description
        languageLabel.text = language
        starCountLabel.text = "★ \(starCount)"
    }
    
    private func construct(){
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
        containerView.layer.borderWidth = 1
        contentView.addSubview(containerView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 2
        contentView.addSubview(descriptionLabel)
        
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.font = UIFont.systemFont(ofSize: 15)
        languageLabel.textColor = .gray
        contentView.addSubview(languageLabel)
        
        starCountLabel.translatesAutoresizingMaskIntoConstraints = false
        starCountLabel.font = UIFont.systemFont(ofSize: 15)
        starCountLabel.textColor = .gray
        starCountLabel.textAlignment = .right
        contentView.addSubview(starCountLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor,constant: 5),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor,constant:  -5),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor,constant: 5),
            descriptionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor,constant:  -5),
            
            languageLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,constant: 10),
            languageLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor,constant: 5),
            languageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -10),
            
            starCountLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,constant: 10),
            starCountLabel.leftAnchor.constraint(equalTo: languageLabel.rightAnchor,constant: 15),
            starCountLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            starCountLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let languageLabel = UILabel()
    private let starCountLabel = UILabel()
}

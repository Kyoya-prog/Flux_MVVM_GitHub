//
//  RrpoeitoryCell.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

import UIKit

final class RepositoryCell:UITableViewCell{
    
    static let reuseIdentifier = "repository-cell"

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
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 5),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant:  -5),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 5),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant:  -5),
            
            languageLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,constant: 10),
            languageLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 5),
            languageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            
            starCountLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,constant: 10),
            starCountLabel.leftAnchor.constraint(equalTo: languageLabel.rightAnchor,constant: 15),
            starCountLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            starCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let languageLabel = UILabel()
    private let starCountLabel = UILabel()
}


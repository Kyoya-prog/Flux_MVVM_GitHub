//
//  FavorireRepositoriesDataSource.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/10.
//

import UIKit

final class FavoriteRepositoriesDataSource: NSObject {

    private let favoriteRepositoryStore: FavoriteRepositoryStore
    private let selectRepositoryActionCreator: SelectRepositoryActionCreator

    init(favoriteRepositoryStore: FavoriteRepositoryStore = .shared,
         actionCreator: SelectRepositoryActionCreator = .shared) {
        self.favoriteRepositoryStore = favoriteRepositoryStore
        self.selectRepositoryActionCreator = actionCreator

        super.init()
    }

    func configure(_ tableView: UITableView) {
        tableView.register(FavoriteRepositoryCell.self, forCellReuseIdentifier: FavoriteRepositoryCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension FavoriteRepositoriesDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRepositoryStore.repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteRepositoryCell.reuseIdentifier, for: indexPath)

        if let repositoryCell = cell as? FavoriteRepositoryCell {
            let repository = favoriteRepositoryStore.repositories[indexPath.row]
            repositoryCell.configure(title: repository.fullName, description: repository.description ?? "", language: repository.language ?? "", starCount: repository.stargazersCount)
        }

        return cell
    }
}

extension FavoriteRepositoriesDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let repository = favoriteRepositoryStore.repositories[indexPath.row]
        selectRepositoryActionCreator.setSelectedRepository(repository)
    }
}

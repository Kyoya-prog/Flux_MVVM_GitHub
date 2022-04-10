//
//  RepositorySearchDataSource.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//


import UIKit

final class RepositorySearchDataSource: NSObject {

    private let searchStore: SearchRepositoryStore
    private let searchRepositoryActionCreator: SearchRepositoryActionCreator
    private let selectRepositoryActionCreator: SelectRepositoryActionCreator

    init(flux: Flux = .shared) {
        self.searchStore = flux.searchRepositoryStore
        self.searchRepositoryActionCreator = flux.searchRepositoryActionCreator
        self.selectRepositoryActionCreator = flux.selectRepositoryActionCreator

        super.init()
    }

    func configure(_ tableView: UITableView) {
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension RepositorySearchDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchStore.repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.reuseIdentifier, for: indexPath)

        if let repositoryCell = cell as? RepositoryCell {
            let repository = searchStore.repositories[indexPath.row]
            repositoryCell.configure(title: repository.fullName, description: repository.description ?? "", language: repository.language ?? "", starCount: repository.stargazersCount)
        }

        return cell
    }
}

extension RepositorySearchDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let repository = searchStore.repositories[indexPath.row]
        selectRepositoryActionCreator.setSelectedRepository(repository)
    }
}

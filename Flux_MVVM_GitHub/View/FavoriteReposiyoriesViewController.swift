//
//  FavoritesViewController.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/10.
//

import UIKit

class FavoriteRepositoriesViewController: UIViewController {
    
    init(favoriteRepositoryStore: FavoriteRepositoryStore = .shared,
         actionCreator: ActionCreator = .init()) {
        self.favoriteRepositoryStore = favoriteRepositoryStore
        self.actionCreator = actionCreator
        dataSource = FavoriteRepositoriesDataSource(favoriteRepositoryStore: favoriteRepositoryStore, actionCreator: actionCreator)
        dataSource.configure(tableView)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "favorite"
        _ = reloadSubscription
        construct()
    }
    
    private let favoriteRepositoryStore: FavoriteRepositoryStore
    private let actionCreator: ActionCreator
    private let dataSource: FavoriteRepositoriesDataSource
    
    private lazy var reloadSubscription : Subscription = {
        return favoriteRepositoryStore.addListener { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }()
    
    private var repositories: [Repository] {
        return favoriteRepositoryStore.repositories
    }
    
    private let tableView = UITableView()
    
    private func construct(){
        view.backgroundColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }


}

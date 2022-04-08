//
//  ViewController.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

import UIKit

class RepositorySearchViewController: UIViewController {
    
    init(searchStore: SearchRepositoryStore = .shared,
         actionCreator: ActionCreator = .init()) {
        self.searchStore = searchStore
        self.actionCreator = actionCreator
        dataSource = RepositorySearchDataSource(searchStore: searchStore, actionCreator: actionCreator)
        dataSource.configure(tableView)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        searchBar.delegate = self
        _ = reloadSubscription
        super.viewDidLoad()
        construct()
    }
    
    private let searchStore: SearchRepositoryStore
    private let actionCreator: ActionCreator
    private let dataSource: RepositorySearchDataSource
    
    private lazy var reloadSubscription : Subscription = {
        return searchStore.addListener { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }()
    
    private var repositories: [Repository] {
        return searchStore.repositories
    }
    
    private let tableView = UITableView()
    
    private let searchBar = UISearchBar()
    
    private func construct(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }


}

extension RepositorySearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            actionCreator.clearRepositories()
            actionCreator.searchRepositories(query: text)
        }
}
}


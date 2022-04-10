//
//  ViewController.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

import RxSwift
import RxCocoa
import UIKit

class RepositorySearchViewController: UIViewController {
    
    init(searchStore: SearchRepositoryStore = .shared,
         actionCreator:
         SearchRepositoryActionCreator = .shared) {
        self.searchStore = searchStore
        self.actionCreator = actionCreator
        dataSource = RepositorySearchDataSource()
        dataSource.configure(tableView)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchStore.repositoryObservable.map{_ in}
            .bind(to: Binder(tableView){ tableview, _ in
                tableview.reloadData()
            }).disposed(by: disposeBag)
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text)
            .subscribe(onNext: { [actionCreator] text in
                if let text = text, !text.isEmpty {
                    actionCreator.clearRepositories()
                    actionCreator.searchRepositories(query: text)
                } })
            .disposed(by: disposeBag)
        
        title = "Search Repositories"
        construct()
    }
    
    private let searchStore: SearchRepositoryStore
    private let actionCreator: SearchRepositoryActionCreator
    private let dataSource: RepositorySearchDataSource
    private let disposeBag = DisposeBag()
    
    private let tableView = UITableView()
    
    private let searchBar = UISearchBar()
    
    private func construct(){
        view.backgroundColor = .white
        
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


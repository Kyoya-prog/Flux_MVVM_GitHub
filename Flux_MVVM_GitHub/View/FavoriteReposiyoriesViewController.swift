//
//  FavoritesViewController.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/10.
//

import UIKit
import RxCocoa
import RxSwift

class FavoriteRepositoriesViewController: UIViewController {
    
    init(flux: Flux = .shared) {
        self.favoriteRepositoryStore = flux.favoriteRepositoryStore
        self.favoriteRepositoryActionCreator = flux.favoriteRepositoryActionCreator
        self.selectedRepositoryActionCreator = flux.selectRepositoryActionCreator
        dataSource = FavoriteRepositoriesDataSource()
        dataSource.configure(tableView)
        
        favoriteRepositoryStore.repositories.asObservable().bind(to: Binder(tableView){ tableView,_ in
            tableView.reloadData()
        }).disposed(by: disposeBag)

        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "favorite"
        construct()
    }
    
    private let favoriteRepositoryStore: FavoriteRepositoryStore
    private let favoriteRepositoryActionCreator: FavoriteRepositoryActionCreator
    private let selectedRepositoryActionCreator: SelectRepositoryActionCreator
    private let dataSource: FavoriteRepositoriesDataSource
    private let disposeBag = DisposeBag()
    
    private var repositories: [Repository] {
        return favoriteRepositoryStore.repositories.value
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

//
//  RepositoryDetailViewController.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

import UIKit
import WebKit

final class RepositoryDetailViewController:UIViewController{
    private let configuration = WKWebViewConfiguration()
    private lazy var webView = WKWebView(frame: .zero, configuration: configuration)
    private let selectedRepositoryStore:SelectedRepositoryStore
    private let favoriteRepositoryStore:FavoriteRepositoryStore
    private let actionCreator: ActionCreator
    
    private lazy var repositoryStoreSubscription: Subscription = {
        favoriteRepositoryStore.addListener { [weak self] in
            DispatchQueue.main.async {
                self?.updateFavoriteButton()
            }
        }
    }()
    
    init(selectedStore:SelectedRepositoryStore = .shared,
         favoriteStore:FavoriteRepositoryStore = .shared,
         actionCreator:ActionCreator = .init()){
        self.selectedRepositoryStore = selectedStore
        self.favoriteRepositoryStore = favoriteStore
        self.actionCreator = actionCreator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let repository = selectedRepositoryStore.repository else { return }
        navigationItem.rightBarButtonItem = favoriteButton
        updateFavoriteButton()
        _ = repositoryStoreSubscription
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        view.addSubview(webView)

        webView.load(URLRequest(url: repository.htmlURL))
    }
    
    private lazy var favoriteButton = UIBarButtonItem(title: nil,
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(self.favoriteButtonTap(_:)))
    
    private func updateFavoriteButton(){
        let isFavorite = favoriteRepositoryStore.repositories.contains {
            $0.id == selectedRepositoryStore.repository?.id
        }
        favoriteButton.title = isFavorite ? "★ Unstar" : "☆ Star"
    }
    
    @objc func favoriteButtonTap(_ sender: UIBarButtonItem){
        guard let repository = selectedRepositoryStore.repository else { return }
        
        if favoriteRepositoryStore.repositories.contains{ $0.id == repository.id}{
            actionCreator.removeFavoriteRepository(repository)
        } else {
            actionCreator.addFavoriteRepository(repository)
        }
    }
    
}

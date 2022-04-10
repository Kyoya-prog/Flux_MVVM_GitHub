//
//  RepositoryDetailViewController.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

final class RepositoryDetailViewController:UIViewController{
    private let configuration = WKWebViewConfiguration()
    private lazy var webView = WKWebView(frame: .zero, configuration: configuration)
    private let selectedRepositoryStore:SelectedRepositoryStore
    private let favoriteRepositoryStore:FavoriteRepositoryStore
    private let actionCreator: FavoriteRepositoryActionCreator
    private let disposeBag = DisposeBag()
    
    init(flux: Flux = .shared){
        self.selectedRepositoryStore = flux.selectedRepositoryStore
        self.favoriteRepositoryStore = flux.favoriteRepositoryStore
        self.actionCreator = flux.favoriteRepositoryActionCreator
        

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpObservableSubscription(){
        let repository = selectedRepositoryStore.repositoryObservable
            .flatMap { repository -> Observable<Repository> in
                repository.map(Observable.just) ?? .empty()
            }
            .share(replay: 1, scope: .whileConnected)

        let isFavorite = favoriteRepositoryStore.repositoriesObservable
            .withLatestFrom(repository) { ($0, $1) }
            .map { repositories, repository -> Bool in
                repositories.contains { $0.id == repository.id }
            }
            .share(replay: 1, scope: .whileConnected)

        isFavorite
            .bind(to: Binder(favoriteButton) { button, isFavorite in
                button.title = isFavorite ? "🌟 Unstar" : "⭐️ Star"
            })
            .disposed(by: disposeBag)

        
        favoriteButton.rx.tap.asObservable()
            .withLatestFrom(isFavorite)
            .withLatestFrom(repository) { ($0, $1) }
            .subscribe(onNext: {[weak self] isFavorite, repository in
                if isFavorite {
                    self?.actionCreator.removeFavoriteRepository(repository)
                } else {
                    self?.actionCreator.addFavoriteRepository(repository)
                }
            })
            .disposed(by: disposeBag)
        
        repository
            .bind(to: Binder(webView) { webView, repository in
                webView.load(URLRequest(url: repository.htmlURL))
            })
            .disposed(by: disposeBag)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = favoriteButton
        setUpObservableSubscription()
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        view.addSubview(webView)

        

    }
    
    private lazy var favoriteButton = UIBarButtonItem(title: nil,
                                                      style: .plain,
                                                      target: self, action: nil)
    
}

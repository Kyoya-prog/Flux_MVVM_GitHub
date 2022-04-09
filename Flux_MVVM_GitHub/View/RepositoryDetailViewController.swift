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
    
    init(selectedStore:SelectedRepositoryStore = .shared){
        self.selectedRepositoryStore = selectedStore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let repository = selectedRepositoryStore.repository else {
            return
        }
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
    
    
}

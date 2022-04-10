//
//  AppDelegate.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

import UIKit
import RxSwift
import RxCocoa

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let actionCreator = ActionCreator()
    private let searchStore = SearchRepositoryStore.shared
    private let selectedRepositoryStore = SelectedRepositoryStore.shared
    
    private lazy var showRepositoryDetailDisposable: Disposable = {
        return selectedRepositoryStore.repositoryObservable
            .flatMap { $0 == nil ? .empty() : Observable.just(()) }
            .bind(to: Binder(self) { me, _ in
                guard
                    let tabBarController = me.window?.rootViewController as? UITabBarController,
                    let navigationController = tabBarController.selectedViewController as? UINavigationController
                else {
                    return
                }
                let vc = RepositoryDetailViewController()
                navigationController.pushViewController(vc, animated: true)
            })
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        let values: [(UINavigationController, UITabBarItem.SystemItem)] = [
            (UINavigationController(rootViewController: RepositorySearchViewController()), .search),
            (UINavigationController(rootViewController: FavoriteRepositoriesViewController()), .favorites)
        ]
        values.enumerated().forEach {
            $0.element.0.tabBarItem = UITabBarItem(tabBarSystemItem: $0.element.1, tag: $0.offset)
        }
        tabBarController.setViewControllers(values.map { $0.0 }, animated: false)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        _ = showRepositoryDetailDisposable
        actionCreator.loadFavoriteRepositories()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}


//
//  SceneDelegate.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let searchStore = SearchRepositoryStore.shared
    private let selectRepositoryStore = SelectedRepositoryStore.shared
    private let favoriteRepositoryActionCreator = FavoriteRepositoryActionCreator.shared
    
    private lazy var showRepositoryDetailDisposable: Disposable = {
        return selectRepositoryStore.repositoryObservable
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


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let tabBarController = UITabBarController()
            let values: [(UINavigationController, UITabBarItem.SystemItem)] = [
                (UINavigationController(rootViewController: RepositorySearchViewController()), .search),
                (UINavigationController(rootViewController: FavoriteRepositoriesViewController()), .favorites)
            ]
            values.enumerated().forEach {
                $0.element.0.tabBarItem = UITabBarItem(tabBarSystemItem: $0.element.1, tag: $0.offset)
            }
            tabBarController.setViewControllers(values.map { $0.0 }, animated: false)
            favoriteRepositoryActionCreator.loadFavoriteRepositories()
            window.rootViewController = tabBarController
            self.window = window
            window.makeKeyAndVisible()
            
            _ = showRepositoryDetailDisposable
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


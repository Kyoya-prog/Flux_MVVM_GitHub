//
//  ActionCreator.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

import Dispatch

final class ActionCreator{
    private let dispatcher:Dispatcher
    private let apiSession:GitHubApiRequestable
    private let localCache: LocalCacheable
    
    init(dispatcher: Dispatcher = .shared,
         apiSession:GitHubApiSession = GitHubApiSession.shared,
         localCache: LocalCacheable = LocalCache.shared){
        self.dispatcher = dispatcher
        self.apiSession = apiSession
        self.localCache = localCache
    }
    
    func searchRepositories(query:String,page:Int = 1){
        _ = apiSession.searchRepositories(query: query, page: page)
            .take(1)
            .subscribe(onNext: { [weak self] (repositories,pagination) in
                self?.dispatcher.searchRepositories.accept(repositories)
            }, onError: {[weak self] error in
                self?.dispatcher.error.accept(error)
            })
    }
    
    func clearRepositories(){
        dispatcher.clearRepositories.accept(())
    }
    
    func setSelectedRepository(repository:Repository){
        
    }
    
    func addFavoriteRepository(_ repository: Repository){
        let repositories = localCache[.favorites] + [repository]
        localCache[.favorites] = repositories
        dispatcher.favoritesRepositories.accept(repositories)
    }
    
    func removeFavoriteRepository(_ repository: Repository){
        let repositories = localCache[.favorites].filter{ $0.id != repository.id }
        localCache[.favorites] = repositories
        dispatcher.favoritesRepositories.accept(repositories)
    }
    
    func loadFavoriteRepositories(){
        let repositories = localCache[.favorites]
        dispatcher.favoritesRepositories.accept(repositories)
    }
}

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
        dispatcher.dispatch(.searchQuery(query))
        dispatcher.dispatch(.isRepositoriesFetching(true))
        _ = apiSession.searchRepositories(query: query, page: page)
            .take(1)
            .subscribe(onNext: { [weak self] (repositories,pagination) in
                self?.dispatcher.dispatch(.searchRepositories(repositories))
                self?.dispatcher.dispatch(.searchPagination(pagination))
                self?.dispatcher.dispatch(.isRepositoriesFetching(false))
            }, onError: {[weak self] error in
                self?.dispatcher.dispatch(.error(error))
                self?.dispatcher.dispatch(.isRepositoriesFetching(false))
            })
        apiSession.searchRepositories(query: query, page: page)
    }
    
    func clearRepositories(){
        dispatcher.dispatch(.clearRepositories)
    }
    
    func setSelectedRepository(repository:Repository){
        dispatcher.dispatch(.selectedRepository(repository))
    }
    
    func addFavoriteRepository(_ repository: Repository){
        let repositories = localCache[.favorites] + [repository]
        localCache[.favorites] = repositories
        dispatcher.dispatch(.setFavoriteRepositories(repositories))
    }
    
    func removeFavoriteRepository(_ repository: Repository){
        let repositories = localCache[.favorites].filter{ $0.id != repository.id }
        localCache[.favorites] = repositories
        dispatcher.dispatch(.setFavoriteRepositories(repositories))
    }
    
    func loadFavoriteRepositories(){
        let repositories = localCache[.favorites]
        dispatcher.dispatch(.setFavoriteRepositories(repositories))
    }
}

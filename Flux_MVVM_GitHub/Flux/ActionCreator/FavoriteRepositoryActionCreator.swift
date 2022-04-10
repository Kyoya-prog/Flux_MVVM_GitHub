//
//  FavoriteRepositoryActionCreator.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/10.
//

import RxRelay

final class FavoriteRepositoryActionCreator{
    static let shared = FavoriteRepositoryActionCreator()
    
    private let localCache:LocalCacheable = LocalCache.shared
    private let dispatcher:FavoriteRepositoryDispatcher = .shared
    
    private init(){}
    
    
    func addFavoriteRepository(_ repository: Repository){
        let repositories = localCache[.favorites] + [repository]
        localCache[.favorites] = repositories
        dispatcher.repositories.accept(repositories)
    }
    
    func removeFavoriteRepository(_ repository: Repository){
        let repositories = localCache[.favorites].filter{ $0.id != repository.id }
        localCache[.favorites] = repositories
        dispatcher.repositories.accept(repositories)
    }
    
    func loadFavoriteRepositories(){
        let repositories = localCache[.favorites]
        dispatcher.repositories.accept(repositories)
    }
}

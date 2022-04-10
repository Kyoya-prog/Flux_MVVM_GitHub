//
//  Flux.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/10.
//

final class Flux {
    static let shared = Flux()
    let searchRepositoryDispatcher: SearchRepositoryDispatcher
    let searchRepositoryActionCreator: SearchRepositoryActionCreator
    let searchRepositoryStore: SearchRepositoryStore = .shared
    
    let favoriteRepositoryDispatcher: FavoriteRepositoryDispatcher
    let favoriteRepositoryActionCreator: FavoriteRepositoryActionCreator
    let favoriteRepositoryStore: FavoriteRepositoryStore
    
    let selectRepositoryDispatcher: SelectRepositoryDispatcher
    let selectRepositoryActionCreator: SelectRepositoryActionCreator
    let selectedRepositoryStore: SelectedRepositoryStore
    
    private init(searchRepositoryDispatcher: SearchRepositoryDispatcher = .shared,
         searchRepositoryActionCreator: SearchRepositoryActionCreator = .shared,
         favoriteRepositoryDispatcher: FavoriteRepositoryDispatcher = .shared,
         favoriteRepositoryActionCreator: FavoriteRepositoryActionCreator = .shared,
         favoriteRepositoryStore: FavoriteRepositoryStore = .shared,
         selectRepositoryDispatcher: SelectRepositoryDispatcher = .shared,
         selectRepositoryActionCreator: SelectRepositoryActionCreator = .shared,
         selectedRepositoryStore: SelectedRepositoryStore = .shared
    ) {
        self.searchRepositoryDispatcher = searchRepositoryDispatcher
        self.searchRepositoryActionCreator = searchRepositoryActionCreator
        
        self.favoriteRepositoryDispatcher = favoriteRepositoryDispatcher
        self.favoriteRepositoryActionCreator = favoriteRepositoryActionCreator
        self.favoriteRepositoryStore = favoriteRepositoryStore
//        self.searchRepositoryStore = searchRepositoryStore
        
        self.selectRepositoryDispatcher = selectRepositoryDispatcher
        self.selectRepositoryActionCreator = selectRepositoryActionCreator
        self.selectedRepositoryStore = selectedRepositoryStore
    }
}

//
//  FavoriteRepositoryStore.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/09.
//

final class FavoriteRepositoryStore : Store {
    static let shared = FavoriteRepositoryStore(dispatcher: .shared)
    
    private(set) var repositories:[Repository] = []
    
    override func onDispatch(_ action:Action){
        switch action {
        case let .setFavoriteRepositories(repositories):
            self.repositories = repositories
        default:
            return
        }
        emitChange()
    }
}

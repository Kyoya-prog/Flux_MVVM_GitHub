//
//  SearchRepositoryStore.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

class SearchRepositoryStore: Store{
    static let shared = SearchRepositoryStore(dispatcher: .shared)
    
    private(set) var repositories:[Repository] = []
    
    override func onDispatch(_ action:Action){
        switch action {
        case let .addRepositories(repositories):
            self.repositories = self.repositories + repositories
        case .clearRepositories:
            self.repositories.removeAll()
        default:
            return
        }
        emitChange()
    }
}

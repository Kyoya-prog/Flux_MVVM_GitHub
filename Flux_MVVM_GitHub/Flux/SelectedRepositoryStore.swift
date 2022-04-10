//
//  SelectedRepositoryStore.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

final class SelectedRepositoryStore:Store{
    
    static let shared = SelectedRepositoryStore(dispatcher: .shared)
    
    private(set) var repository:Repository?
    
    override func onDispatch(_ action: Action) {
        switch action{
        case let .selectedRepository(repository):
            self.repository = repository
        default:
            return
        }
        emitChange()
    }
}

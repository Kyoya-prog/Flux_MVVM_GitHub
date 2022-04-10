//
//  SelectRepositoryActionCreator.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/10.
//

final class SelectRepositoryActionCreator{
    static let shared = SelectRepositoryActionCreator()
    
    let dispatcher:SelectedRepositoryDispatcher
    
    private init(dispatcher:SelectedRepositoryDispatcher = .shared){
        self.dispatcher = dispatcher
    }
    
    func setSelectedRepository(_ repository:Repository){
        dispatcher.repository.accept(repository)
    }
}

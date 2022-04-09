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
    
    init(dispatcher: Dispatcher = .shared, apiSession:GitHubApiSession = GitHubApiSession.shared){
        self.dispatcher = dispatcher
        self.apiSession = apiSession
    }
    
    func searchRepositories(query:String,page:Int = 1){
        apiSession.searchRepositories(query: query, page: page) {[weak self] result in
            switch result {
            case let .success((repositories, _)):
                self?.dispatcher.dispatch(.addRepositories(repositories))
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func clearRepositories(){
        dispatcher.dispatch(.clearRepositories)
    }
    
    func setSelectedRepository(repository:Repository){
        dispatcher.dispatch(.selectedRepository(repository))
    }
}

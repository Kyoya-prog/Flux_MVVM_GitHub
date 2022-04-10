//
//  SearchRepositoryActionCreator.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/10.
//

final class SearchRepositoryActionCreator{
    static let shared = SearchRepositoryActionCreator()
    
    private let apiSession:GitHubApiRequestable = GitHubApiSession.shared
    private let dispatcher:SearchRepositoryDispatcher = .shared
    
    private init(){}
    
    
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
}

//
//  SearchRepositoryStore.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//
import RxRelay
import RxSwift
import Foundation

class SearchRepositoryStore {
    static let shared = SearchRepositoryStore()
    
    var repositories: [Repository]{
        _repositories.value
    }
    
    var repositoryObservable:Observable<[Repository]>{
        return _repositories.asObservable()
    }
    
    private let _repositories = BehaviorRelay<[Repository]>(value: [])
    
    var errorObservable: Observable<Error> {
        return _error.asObservable()
    }
    private let _error = PublishRelay<Error>()
    private let disposeBag = DisposeBag()
    
    init(dispatcher: SearchRepositoryDispatcher = .shared) {
        dispatcher.searchRepositories.subscribe(onNext: {[weak self] repositories in
            self?._repositories.accept(repositories)
        }, onError: {[weak self] error in
            self?._error.accept(error)
        }).disposed(by: disposeBag)
        dispatcher.clearRepositories.subscribe { [weak self] _ in
            self?._repositories.accept([])
        }.disposed(by: disposeBag)

    }
}

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
    static let shared = SearchRepositoryStore(dispatcher: .shared)
    
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
    
    init(dispatcher: Dispatcher = .shared) {
        dispatcher.register { [weak self] action in
            guard let self = self else { return }
            switch action{
            case let .searchRepositories(repositories):
                self._repositories.accept(repositories)
            case .clearRepositories:
                self._repositories.accept([])
            case let .error(error):
                self._error.accept(error)
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
}

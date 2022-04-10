//
//  SearchRepositoryStore.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//
import RxRelay
import RxSwift
import Foundation

final class SearchRepositoryStore {
    static let shared = SearchRepositoryStore()
    let repositories: Property<[Repository]>
    private let _repositories = BehaviorRelay<[Repository]>(value: [])
    let error: Observable<Error>
    private let disposeBag = DisposeBag()
    init(dispatcher: SearchRepositoryDispatcher = .shared) {
        
        self.repositories = Property(_repositories)
        self.error = dispatcher.error.asObservable()
        
        dispatcher.searchRepositories
            .withLatestFrom(_repositories) { $1 + $0 }
            .bind(to: _repositories)
            .disposed(by: disposeBag)
        dispatcher.clearRepositories
            .map { [] }
            .bind(to: _repositories)
            .disposed(by: disposeBag)
    }
}

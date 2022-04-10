//
//  FavoriteRepositoryStore.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/09.
//

import Foundation
import RxRelay
import RxSwift

final class FavoriteRepositoryStore{
    static let shared = FavoriteRepositoryStore()
    
    var repositories:Property<[Repository]>
    private let _favoriteRepositories = BehaviorRelay<[Repository]>(value:[])
    
    var errorObservable: Observable<Error> {
        return _error.asObservable()
    }
    private let _error = PublishRelay<Error>()
    private let disposeBag = DisposeBag()
    
    init(dispatcher: FavoriteRepositoryDispatcher = .shared){
        self.repositories = Property(_favoriteRepositories)
        dispatcher.repositories
            .subscribe {[weak self] repositories in
                self?._favoriteRepositories.accept(repositories)
            }

    }
}

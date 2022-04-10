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
    static let shared = FavoriteRepositoryStore(dispatcher: .shared)
    
    var repositories:[Repository]{
        _favoriteRepositories.value
    }
    
    var repositoriesObservable:Observable<[Repository]>{
        _favoriteRepositories.asObservable()
    }
    
    private let _favoriteRepositories = BehaviorRelay<[Repository]>(value:[])
    
    var errorObservable: Observable<Error> {
        return _error.asObservable()
    }
    private let _error = PublishRelay<Error>()
    private let disposeBag = DisposeBag()
    
    init(dispatcher: Dispatcher = .shared){
        dispatcher.register {[weak self] action in
            guard let self = self else { return }
            switch action{
            case let .setFavoriteRepositories(repositories):
                self._favoriteRepositories.accept(repositories)
            case let .error(error):
                self._error.accept(error)
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
}

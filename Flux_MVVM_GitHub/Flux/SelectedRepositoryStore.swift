//
//  SelectedRepositoryStore.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

import RxSwift
import RxRelay

final class SelectedRepositoryStore{
    
    static let shared = SelectedRepositoryStore(dispatcher: .shared)
    
    var repositoryObservable:Observable<Repository?>{
        _repository.asObservable()
    }
    
    private let _repository = BehaviorRelay<Repository?>(value: nil)
    private let disposeBag = DisposeBag()
    
    init(dispatcher:Dispatcher = .shared){
        dispatcher.register {[weak self] action in
            guard let self = self else { return }
            switch action{
            case let .selectedRepository(repository):
                self._repository.accept(repository)
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
    

}

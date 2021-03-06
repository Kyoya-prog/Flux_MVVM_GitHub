//
//  SelectedRepositoryStore.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

import RxSwift
import RxRelay

final class SelectedRepositoryStore{
    
    static let shared = SelectedRepositoryStore()
    
    var repository:Property<Repository?>
    
    
    private let _repository = BehaviorRelay<Repository?>(value: nil)
    private let disposeBag = DisposeBag()
    
    init(dispatcher:SelectRepositoryDispatcher = .shared){
        self.repository = Property(_repository)
        dispatcher.repository
            .bind(to: _repository)
            .disposed(by: disposeBag)
    }
    

}

//
//  Dispatcher.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

import RxSwift
import RxRelay

typealias DispatchToken = String

final class Dispatcher {
    static let shared = Dispatcher()
    
    private let _action = PublishRelay<Action>()
    
    func register(callback: @escaping (Action)->())->Disposable{
        _action.subscribe(onNext: callback)
    }
    
    func dispatch(_ action:Action){
        _action.accept(action)
    }
}

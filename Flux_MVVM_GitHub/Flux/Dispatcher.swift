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
    
    let searchRepositories = PublishRelay<[Repository]>()
    
    let clearRepositories = PublishRelay<Void>()
    
    let error = PublishRelay<Error>()
    
    let selectedRepository = PublishRelay<Repository>()
    
    let favoritesRepositories = PublishRelay<[Repository]>()
}

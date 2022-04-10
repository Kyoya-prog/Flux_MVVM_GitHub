//
//  SearchRepositoryDispatcher.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/10.
//

import RxRelay

final class SearchRepositoryDispatcher{
    static let shared = SearchRepositoryDispatcher()
    let searchRepositories = PublishRelay<[Repository]>()
    let clearRepositories = PublishRelay<Void>()
    let error = PublishRelay<Error>()
    
    private init(){}
}

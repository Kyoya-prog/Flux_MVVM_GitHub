//
//  FavoriteRepositoryDispatcher.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/10.
//

import RxRelay

final class FavoriteRepositoryDispatcher{
    static let shared = FavoriteRepositoryDispatcher()

    let repositories = PublishRelay<[Repository]>()
    
    private init(){}
}

//
//  SelectRepositoryDispatcher.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/10.
//

import RxRelay


final class SelectRepositoryDispatcher{
    static let shared = SelectRepositoryDispatcher()
    let repository = PublishRelay<Repository>()
}

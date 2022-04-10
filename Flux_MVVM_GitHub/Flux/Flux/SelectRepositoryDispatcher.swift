//
//  SelectRepositoryDispatcher.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/10.
//

import RxRelay


final class SelectedRepositoryDispatcher{
    static let shared = SelectedRepositoryDispatcher()
    let repository = PublishRelay<Repository>()
}

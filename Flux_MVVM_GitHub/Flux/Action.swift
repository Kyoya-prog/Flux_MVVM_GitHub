//
//  Action.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

enum Action{
    case addRepositories([Repository])
    case clearRepositories
    case selectedRepository(Repository)
    case setFavoriteRepositories([Repository])
}

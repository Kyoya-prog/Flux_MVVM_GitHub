//
//  Action.swift
//  Flux_MVVM_GitHub
//
//  Created by 松山響也 on 2022/04/08.
//

enum Action{
    case searchQuery(String?)
    case searchPagination(Pagination?)
    case searchRepositories([Repository])
    case clearRepositories
    case isRepositoriesFetching(Bool)
    case isSearchFieldEditing(Bool)
    case error(Error)

    case setFavoriteRepositories([Repository])

    case selectedRepository(Repository?)
}

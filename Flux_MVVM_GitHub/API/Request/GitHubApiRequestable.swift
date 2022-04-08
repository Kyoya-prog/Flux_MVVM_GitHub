//
//  GitHubApiRequestable.swift
//  Flux-MVVM
//
//  Created by 松山響也 on 2022/04/06.
//

import RxSwift

//protocol GitHubApiRequestable: AnyObject{
//    func searchRepositories(query: String,page: Int) -> Observable<([Repository], Pagination)>
//}
//
//final class GitHubApiSession: GitHubApiRequestable {
//    static let shared = GitHubApiSession()
//
//    private let session = ApiClient.shared
//
//    func searchRepositories(query: String, page: Int)  -> Observable<([Repository], Pagination)> {
//        return Single.create { [session] event in
//            let request = SearchRepositoriesRequest(query: query, sort: .stars, order: .desc, page: page, perPage: nil)
//            let task = session.send(request) { result in
//                switch result {
//                case let .success((response, pagination)):
//                    event(.success((response.items, pagination)))
//                case let .failure(error):
//                    event(.failure(error))
//                }
//            }
//            return Disposables.create {
//                task?.cancel()
//            }
//        }
//        .asObservable()
//    }
//}

protocol GitHubApiRequestable: class {
    func searchRepositories(query: String, page: Int, completion: @escaping (Result<([Repository], Pagination)>) -> ())
}

final class GitHubApiSession: GitHubApiRequestable {
    static let shared = GitHubApiSession()

    private let session = ApiClient.shared

    func searchRepositories(query: String, page: Int, completion: @escaping (Result<([Repository], Pagination)>) -> ()) {
        let request = SearchRepositoriesRequest(query: query, sort: .stars, order: .desc, page: page, perPage: nil)
        session.send(request) { result in
            switch result {
            case let .success((response, pagination)):
                completion(.success((response.items, pagination)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

//
//  SearchRepositoriesRequest.swift
//  Flux-MVVM
//
//  Created by 松山響也 on 2022/04/08.
//
struct SearchRepositoriesRequest: Request {
    typealias Response = ItemsResponse<Repository>

    let method: HttpMethod = .get
    let path = "/search/repositories"

    var queryParameters: [String : String]? {
        var params: [String: String] = ["q": query]
        if let page = page {
            params["page"] = "\(page)"
        }
        if let perPage = perPage {
            params["per_page"] = "\(perPage)"
        }
        if let sort = sort {
            params["sort"] = sort.rawValue
        }
        if let order = order {
            params["order"] = order.rawValue
        }
        return params
    }

    let query: String
    let sort: Sort?
    let order: Order?
    let page: Int?
    let perPage: Int?

public init(query: String, sort: Sort?, order: Order?, page: Int?, perPage: Int?) {
        self.query = query
        self.sort = sort
        self.order = order
        self.page = page
        self.perPage = perPage
    }
}

extension SearchRepositoriesRequest {
    enum Sort: String {
        case stars
        case forks
        case updated
    }

    enum Order: String {
        case asc
        case desc
    }
}

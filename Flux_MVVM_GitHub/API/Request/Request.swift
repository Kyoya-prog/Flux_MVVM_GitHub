//
//  Request.swift
//  Flux-MVVM
//
//  Created by 松山響也 on 2022/04/06.
//

import Foundation

public protocol Request {
    associatedtype Response: Decodable
    var baseURL: URL { get }
    var method: HttpMethod { get }
    var path: String { get }
    var headerFields: [String: String] { get }
    var queryParameters: [String: String]? { get }
}

extension Request {
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    public var headerFields: [String: String] {
        return ["Accept": "application/json"]
    }

    public var queryParameters: [String: String]? {
        return nil
    }
}

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

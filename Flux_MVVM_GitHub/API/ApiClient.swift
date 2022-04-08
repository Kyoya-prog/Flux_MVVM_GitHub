//
//  ApiClient.swift
//  Flux-MVVM
//
//  Created by 松山響也 on 2022/04/06.
//

import Foundation

public enum SessionError: Error {

    case noData(HTTPURLResponse)
    case noResponse
    case unacceptableStatusCode(Int)
    case failedToCreateComponents(URL)
    case failedToCreateURL(URLComponents)
}

final class ApiClient{
    static let shared = ApiClient()
    
    public func send<T: Request>(_ request: T,
                                 completion: @escaping (Result<(T.Response, Pagination)>) -> ()) -> URLSessionTask? {
        let url = request.baseURL.appendingPathComponent(request.path)

        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(SessionError.failedToCreateComponents(url)))
            return nil
        }
        components.queryItems = request.queryParameters?.compactMap(URLQueryItem.init)

        guard var urlRequest = components.url.map({ URLRequest(url: $0) }) else {
            completion(.failure(SessionError.failedToCreateURL(components)))
            return nil
        }

        urlRequest.httpMethod = request.method.rawValue


        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(SessionError.noResponse))
                return
            }

            guard let data = data else {
                completion(.failure(SessionError.noData(response)))
                return
            }

            guard  200..<300 ~= response.statusCode else {
                completion(.failure(SessionError.unacceptableStatusCode(response.statusCode)))
                return
            }
            
            let pagination: Pagination
            if let link = response.allHeaderFields["Link"] as? String {
                pagination = Pagination(link: link)
            } else {
                pagination = Pagination(next: nil, last: nil, first: nil, prev: nil)
            }

            do {
                let object = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.success((object,pagination)))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()

        return task
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

//
//  HTTPClient.swift
//  GitRx
//
//  Created by Михаил Нечаев on 22.12.2019.
//  Copyright © 2019 Михаил Нечаев. All rights reserved.
//

import Foundation
import RxSwift

final class HTTPClient {
    
    // MARK: - Enums

    enum Method: String {
        case search = "search/repositories"
        case readme = "readme"
    }
    
    enum ResponseResult {
        case success(response: Data)
        case error(message: String)
    }
    
    // MARK: - Private properties
    
    private var baseURL: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        return components
    }
    
    // MARK: - Api calls
    
    func search(with query: String, completion: @escaping(ResponseResult)->Void) {
        var urlComponents = baseURL
        guard !query.isEmpty else {
            return
        }
        urlComponents.queryItems = [URLQueryItem(name: "q", value: query)]
        call(with: urlComponents, method: .search, completion: completion)
    }
    
    func readme(for userName: String, repo: String, completion: @escaping(ResponseResult)->Void) {
        var urlComponents = baseURL
        urlComponents.path.append("/repos/\(userName)/\(repo)")
        call(with: urlComponents, method: .readme, completion: completion)
    }
    
    // MARK: - Core function

    private func call(with urlComponents: URLComponents, method: Method, completion: @escaping(ResponseResult)->Void) {
        guard var url = urlComponents.url else {
            return
        }
        url.appendPathComponent(method.rawValue)
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        let urlsession = URLSession(configuration: .default)
        urlsession.dataTask(with: urlRequest) { (data, response, error) in
            if let _ = error {
                completion(.error(message: "Internal error"))
            }
            if let unwrappedData = data {
                completion(.success(response: unwrappedData))
            } else {
                completion(.error(message: "Empty data"))
            }
        }.resume()
    }
    
}

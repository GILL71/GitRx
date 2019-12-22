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

//    enum Method: String {
//        case search = "search/repositories"
//        case readme = "README"
//    }
    
    // MARK: - Private properties
    
    private var baseURL: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        return components
    }
    
    func search(with query: String, completion: @escaping(MainResponse)->Void) {
        var urlComponents = baseURL
        guard !query.isEmpty else {
            return
        }
        urlComponents.queryItems = [URLQueryItem(name: "q", value: query)]
        guard var url = urlComponents.url else {
            return
        }
        url.appendPathComponent("search/repositories")
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        let urlsession = URLSession(configuration: .default)
        urlsession.dataTask(with: urlRequest) { (data, response, error) in
            if let unwrappedError = error {
                //распространить ошибку
            }
            do {
                let encoded = try JSONDecoder().decode(MainResponse.self, from: data!)
                print(encoded)
                completion(encoded)
            } catch {
                //распространить ошибку парсинга
                print(error.localizedDescription)
            }
            print("________")
            print(response)
            print("________")
            print(error)
            print("________")
        }.resume()

    }

}

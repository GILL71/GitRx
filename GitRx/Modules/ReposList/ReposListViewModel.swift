//
//  ReposListViewModel.swift
//  GitRx
//
//  Created by Михаил Нечаев on 22.12.2019.
//  Copyright © 2019 Михаил Нечаев. All rights reserved.
//

import RxSwift

final class ReposListViewModel {
    
    let repos : PublishSubject<[RepoResponse]> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    private let httpClient = HTTPClient()
    
    func search(with query: String) {
        isLoading.onNext(true)
        httpClient.search(with: query) { [weak self] (response) in
            switch response {
            case let .success(data):
                do {
                    let encoded = try JSONDecoder().decode(MainResponse.self, from: data)
                    self?.repos.onNext(encoded.items)
                } catch {
                    self?.error.onNext("Parse error")
                }
            case let .error(message):
                self?.error.onNext(message)
            }
            self?.isLoading.onNext(false)
        }
    }
    
}

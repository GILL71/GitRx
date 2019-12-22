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
    private let httpClient = HTTPClient()
    
    func search(with query: String) {
        isLoading.onNext(true)
        httpClient.search(with: query) { [weak self] (response) in
            self?.repos.onNext(response.items)
            self?.isLoading.onNext(false)
        }
    }
    
}

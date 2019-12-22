//
//  ImageLoader.swift
//  GitRx
//
//  Created by Михаил Нечаев on 22.12.2019.
//  Copyright © 2019 Михаил Нечаев. All rights reserved.
//

import RxSwift

final class ImageLoader {
    
    let imageData: PublishSubject<Data> = PublishSubject()
    private let disposeBag = DisposeBag()

    func load(with urlString: String, onNext: @escaping(Data)->Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.rx
            .response(request: request)
            .subscribeOn(MainScheduler.instance)
            .subscribe { (event) in
                if let data = event.element?.data {
                    onNext(data)
                }
        }
    }

}

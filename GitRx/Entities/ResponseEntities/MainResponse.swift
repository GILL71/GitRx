//
//  MainResponse.swift
//  GitRx
//
//  Created by Михаил Нечаев on 22.12.2019.
//  Copyright © 2019 Михаил Нечаев. All rights reserved.
//

import Foundation

struct MainResponse: Codable {
    
    let items: [RepoResponse]

}

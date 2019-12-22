//
//  RepoResponse.swift
//  GitRx
//
//  Created by Михаил Нечаев on 22.12.2019.
//  Copyright © 2019 Михаил Нечаев. All rights reserved.
//

import Foundation

struct RepoResponse: Codable {
    
    let updateDate: String
    let starsCount: Int
    let owner: OwnerResponse
    let language: String?
    let description: String
    let forksCount: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case updateDate = "updated_at"
        case starsCount = "stargazers_count"
        case owner
        case language
        case description
        case forksCount = "forks_count"
        case name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        language = try? container.decode(String.self, forKey: .language)
        starsCount = try container.decode(Int.self, forKey: .starsCount)
        forksCount = try container.decode(Int.self, forKey: .forksCount)
        updateDate = try container.decode(String.self, forKey: .updateDate)
        owner = try container.decode(OwnerResponse.self, forKey: .owner)
    }

}

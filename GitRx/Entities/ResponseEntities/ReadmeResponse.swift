//
//  ReadmeResponse.swift
//  GitRx
//
//  Created by Михаил Нечаев on 22.12.2019.
//  Copyright © 2019 Михаил Нечаев. All rights reserved.
//

import Foundation

struct ReadmeResponse: Codable {
    
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let newContent = try container.decode(String.self, forKey: .content)
        if let data = Data(base64Encoded: newContent, options: .ignoreUnknownCharacters), let string = String(data: data, encoding: .utf8) {
            content = string
        } else {
            content = ""
        }
    }
}

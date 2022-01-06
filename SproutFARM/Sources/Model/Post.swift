//
//  Post.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import Foundation

class Post: Codable {
  let id: Int
  let text: String
  let user: User
  let createdAt: String
  let updatedAt: String
  
  enum codingKeys: String, CodingKey {
    case id, text, user
    case createdAt = "created_at"
    case updatedAt = "updated_at"
  }
}

typealias PostInfo = [Post]

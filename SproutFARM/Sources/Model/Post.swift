//
//  Post.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import Foundation

struct FramPost: Codable {
  let id: Int
  let text: String
  let user: User
  let createdAt: String
  let updatedAt: String
  let comments: [Comment]
  
  enum CodingKeys: String, CodingKey {
    case id, text, user, comments
    case createdAt = "created_at"
    case updatedAt = "updated_at"
  }
}

typealias PostInfo = [FramPost]

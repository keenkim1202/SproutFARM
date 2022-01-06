//
//  Comment.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import Foundation

struct Comment: Codable {
  let id: Int
  let comment: String
  let user: Int
  let post: Int
  let createdAt: String
  let updatedAt: String
  
  enum CodingKeys: String, CodingKey {
    case id, comment, user, post
    case createdAt = "created_at"
    case updatedAt = "updated_at"
  }
}

typealias CommentInfo = [Comment]

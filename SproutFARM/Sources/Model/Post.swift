//
//  Post.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import Foundation

// struct Post: Codable {
//   let id: Int
//   let text: String
//   let user: User
//   let createdAt: String
//   let updatedAt: String
//   let comments: [Comment]
//
//   enum CodingKeys: String, CodingKey {
//     case id, text, user, comments
//     case createdAt = "created_at"
//     case updatedAt = "updated_at"
//   }
// }

struct Post: Codable {
  let id: Int
  let text: String
  let user: UserInfo
  let createdAt, updatedAt: String
  let comments: [Comment]
  
  enum CodingKeys: String, CodingKey {
    case id, text, user
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case comments
  }
}

typealias PostInfo = [Post]

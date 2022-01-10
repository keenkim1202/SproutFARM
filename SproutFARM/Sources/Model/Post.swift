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
  let createdAt, updatedAt: Date
  let comments: [Comment]
  
  enum CodingKeys: String, CodingKey {
    case id, text, user
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case comments
  }
}

typealias PostInfo = [Post]

extension Post {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try container.decode(Int.self, forKey: .id)
    text = try container.decode(String.self, forKey: .text)
    user = try container.decode(UserInfo.self, forKey: .user)
    comments = try container.decode([Comment].self, forKey: .comments)
    
    let createdDateString = try container.decode(String.self, forKey: .createdAt)
    let updatedDateString = try container.decode(String.self, forKey: .updatedAt)
    let formatter = DateFormatter.customFormat
    if let update = formatter.date(from: updatedDateString), let create = formatter.date(from: createdDateString)  {
      updatedAt = update
      createdAt = create
    } else {
      throw DecodingError.dataCorruptedError(forKey: .updatedAt,
              in: container,
              debugDescription: "Date string does not match format expected by formatter.")
    }
  }
}

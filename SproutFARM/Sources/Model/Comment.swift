//
//  Comment.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import Foundation

// post 조회시 나오는 comment
struct PostComment: Codable {
    let id: Int
    let comment: String
    let user, post: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias PostCommentInfo = [PostComment]

// comment 조회시 나오는 comment
struct Comment: Codable {
  let comment: String
  let user: UserType
  let createdAt, updatedAt: Date
  
  enum CodingKeys: String, CodingKey {
      case comment, user
      case createdAt = "created_at"
      case updatedAt = "updated_at"
  }
}

extension Comment {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    comment = try container.decode(String.self, forKey: .comment)
    user = try container.decode(UserType.self, forKey: .user)
    
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

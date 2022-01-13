//
//  Comment.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import Foundation

// comment 조회시 나오는 comment 모델
struct Comment: Codable {
  let id: Int
  let comment: String
  let user: UserType
  let post: CommentPostInfo
  let createdAt, updatedAt: Date
  
  enum CodingKeys: String, CodingKey {
      case id, comment, user, post
      case createdAt = "created_at"
      case updatedAt = "updated_at"
  }
}

// comment 조회시 나오는 Post 모델
struct CommentPostInfo: Codable {
  let id: Int
  let text: String
  let user: Int
}

extension Comment {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try container.decode(Int.self, forKey: .id)
    comment = try container.decode(String.self, forKey: .comment)
    user = try container.decode(UserType.self, forKey: .user)
    post = try container.decode(CommentPostInfo.self, forKey: .post)
    
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

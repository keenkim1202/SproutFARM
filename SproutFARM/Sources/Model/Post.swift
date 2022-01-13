//
//  Post.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import Foundation

// post 조회시 사용되는 Post 모델
struct Post: Codable {
  let id: Int
  let text: String
  let user: UserInfo
  let createdAt, updatedAt: Date
  let comments: [PostCommentInfo]
  
  enum CodingKeys: String, CodingKey {
    case id, text, user
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case comments
  }
}

// post 조회시 나오는 comment 모델
struct PostCommentInfo: Codable {
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

typealias PostInfo = [Post]

extension Post {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try container.decode(Int.self, forKey: .id)
    text = try container.decode(String.self, forKey: .text)
    user = try container.decode(UserInfo.self, forKey: .user)
    comments = try container.decode([PostCommentInfo].self, forKey: .comments)
    
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

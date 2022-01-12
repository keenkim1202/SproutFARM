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
  let createdAt, updatedAt: String
  
  enum CodingKeys: String, CodingKey {
      case comment, user
      case createdAt = "created_at"
      case updatedAt = "updated_at"
  }
}

/*
 "id": 1660,
     "comment": "123",
     "user": {
       "id": 224,
       "username": "Neph",
       "email": "neph1234@naver.com",
       "provider": "local",
       "confirmed": true,
       "blocked": null,
       "role": 1,
       "created_at": "2022-01-05T09:18:58.072Z",
       "updated_at": "2022-01-05T09:18:58.093Z"
     },
 */

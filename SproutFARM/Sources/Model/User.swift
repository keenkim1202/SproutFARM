//
//  User.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import Foundation

// 회원가입 로그인 시 사용되는 사용자 정보
class User: Codable {
  let jwt: String
  let user: UserType
}

struct UserType: Codable {
  let id: Int
  let username, email: String
}

// post 조회 시, user에 해당하는 정보
struct UserInfo: Codable {
  let id: Int
  let username, email, createdAt, updatedAt: String
  
  enum CodingKeys: String, CodingKey {
    case id, username, email
    case createdAt = "created_at"
    case updatedAt = "updated_at"
  }
}

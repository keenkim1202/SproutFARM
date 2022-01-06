//
//  User.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import Foundation

class User: Codable {
  let jwt: String
  let user: UserClass
}

struct UserClass: Codable {
  let id: Int
  let username, email: String
}

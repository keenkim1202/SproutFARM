//
//  APIService.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import Foundation

enum APIError: Error {
  case invalidResponse
  case noData
  case failed
  case invalideData
}

enum HttpMethod: String {
  case POST
  case GET
  case PUT
  case DELETE
}

struct EndPoint {
  static let baseURL = "http://test.monocoding.com:1231"
  
  static let login = baseURL + "/auth/local"
  static let sigup = baseURL + "/auth/local/register"
  static let posts = baseURL + "/posts"
}

class APIService {
  
  // MARK: - login
  static func login(email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
    let url = URL(string: EndPoint.login)!
    
    var request = URLRequest(url: url)
    request.httpMethod = HttpMethod.POST.rawValue
    request.httpBody = "identifier=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
    
    URLSession.shared.request(request, completion: completion)
  }
  
  // MARK: - Signup
  static func signUp(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
    let url = URL(string: EndPoint.sigup)!
    
    var request =  URLRequest(url: url)
    request.httpMethod = HttpMethod.POST.rawValue
    request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
    
    URLSession.shared.request(request, completion: completion)
  }
  
  // MARK: - Posts
  static func fetchPosts(token: String, start: Int, limit: Int, sort: String = "created_at:desc", completion: @escaping (FramPost?, APIError?) -> Void) {
    var components = URLComponents(string: EndPoint.posts)!
    components.queryItems = [
      URLQueryItem(name: "_start", value: "\(start)"),
      URLQueryItem(name: "_limit", value: "\(limit)"),
      URLQueryItem(name: "_sort", value: sort)
    ]
    
    var request = URLRequest(url: components.url!)
    request.httpMethod = HttpMethod.GET.rawValue
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    URLSession.shared.postRequest(request, completion: completion)
  }
  
  static func writePost(text: String, user: User, completion: @escaping (APIError?) -> Void) {
    let url = URL(string: EndPoint.posts)!
    
    var request = URLRequest(url: url)
    request.httpMethod = HttpMethod.POST.rawValue
    request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
    request.setValue("Bearer \(user.jwt)", forHTTPHeaderField: "Authorization")
    
    URLSession.shared.postRequest(request, completion: completion)
  }
  
  // static func deletePost(id: Int, user: User, completion: @escaping (APIError?) -> Void) {
  //   let url = URL(string: EndPoint.posts)!
  //
  //   var request = URLRequest(url: url)
  //   request.httpMethod = HttpMethod.DELETE.rawValue
  //   request.setValue("Bearer \(user.jwt)", forHTTPHeaderField: "Authorization")
  //   request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  //
  //   URLSession.shared.postRequest(request, completion: completion)
  // }
  
}


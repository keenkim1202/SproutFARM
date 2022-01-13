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
  static let comments = baseURL + "/comments"
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
  static func fetchPosts(token: String, start: Int, limit: Int, sort: String = "created_at:desc", completion: @escaping ([Post]?, APIError?) -> Void) {
    var components = URLComponents(string: EndPoint.posts)!
    components.queryItems = [
      URLQueryItem(name: "_start", value: "\(start)"),
      URLQueryItem(name: "_limit", value: "\(limit)"),
      URLQueryItem(name: "_sort", value: sort)
    ]
    
    var request = URLRequest(url: components.url!)
    request.httpMethod = HttpMethod.GET.rawValue
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    URLSession.shared.request(request, completion: completion)
  }
  
  // MARK: - Comment
  static func fetchComments(token: String, postID: Int, completion: @escaping ([Comment]?, APIError?) -> Void) {
    var components = URLComponents(string: EndPoint.comments)!
    components.queryItems = [
      URLQueryItem(name: "post", value: "\(postID)"),
      URLQueryItem(name: "_sort", value: "created_at:desc")
    ]
  
    var request = URLRequest(url: components.url!)
    request.httpMethod = HttpMethod.GET.rawValue
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    URLSession.shared.request(request, completion: completion)
  }
  
  static func writeComment(token: String, comment: String, postID: Int, completion: @escaping (APIError?) -> Void) {
    let url = URL(string: EndPoint.comments)!
  
    var request = URLRequest(url: url)
    request.httpMethod = HttpMethod.POST.rawValue
    request.httpBody = "comment=\(comment)&post=\(postID)".data(using: .utf8, allowLossyConversion: false)
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
  
    URLSession.shared.request(request, completion: completion)
  }
  
  static func updateComment(token: String, comment: String, postID: Int, commentID: Int, completion: @escaping (APIError?) -> Void) {
    let url = URL(string: EndPoint.comments + "/\(commentID)")!
    print(url)
    print("comment: \(comment)")
    var request = URLRequest(url: url)
    request.httpMethod = HttpMethod.PUT.rawValue
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpBody = "comment=\(comment)&post=\(postID)".data(using: .utf8, allowLossyConversion: false)
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
  
    URLSession.shared.request(request, completion: completion)
  }
  
  static func deleteComment(token: String, postID: Int, completion: @escaping (APIError?) -> Void) {
    let url = URL(string: EndPoint.comments + "/\(postID)")!
  
    var request = URLRequest(url: url)
    request.httpMethod = HttpMethod.DELETE.rawValue
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
  
    URLSession.shared.request(request, completion: completion)
  }
  
}


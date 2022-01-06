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
  static let fetchPosts = baseURL + "/posts"
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
  static func fetchPosts(token: String, completion: @escaping (Post?, APIError?) -> Void) {
    let url = URL(string: EndPoint.fetchPosts)!
    
    var request = URLRequest(url: url)
    request.httpMethod = HttpMethod.GET.rawValue
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    URLSession.shared.postRequest(request, completion: completion)
  }
  
}


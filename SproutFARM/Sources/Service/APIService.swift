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
  
}


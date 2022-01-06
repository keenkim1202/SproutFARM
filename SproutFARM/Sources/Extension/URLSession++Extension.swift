//
//  URLSession++Extension.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import Foundation

// TODO: 좀 더 재사용성 높이기

extension URLSession {
  // user request
  func request<T: Decodable>(_ request: URLRequest, completion: @escaping(T?, APIError?) -> Void) {
    URLSession.shared.dataTask(with: request) { data, response, error in
      DispatchQueue.main.async {
        guard error == nil else {
          completion(nil, .failed)
          return
        }
        guard let data = data else {
          completion(nil, .noData)
          return
        }
        guard let response = response as? HTTPURLResponse else {
          completion(nil, .invalidResponse)
          return
        }
        guard response.statusCode == 200 else {
          completion(nil, .failed)
          return
        }
        
        do {
          let decoder = JSONDecoder()
          let userData = try decoder.decode(T.self, from: data)
          completion(userData, nil)
        } catch {
          completion(nil, .invalideData)
        }
      }

    }.resume()
  }
  
  // post request
  // TODO: Post정보를 가져오는데 실패중..
  func postRequest(_ request: URLRequest, completion: @escaping(FramPost?, APIError?) -> Void) {
    URLSession.shared.dataTask(with: request) { data, response, error in
      DispatchQueue.main.async {
        guard error == nil else {
          completion(nil, .failed)
          return
        }
  
        guard let data = data else {
          completion(nil, .noData)
          return
        }
  
        guard let response = response as? HTTPURLResponse else {
          completion(nil, .invalidResponse)
          return
        }
  
        guard response.statusCode == 200 else {
          completion(nil, .failed)
          return
        }
        
        do {
  
          let decoder = JSONDecoder()
          let postInfo = try decoder.decode(PostInfo.self, from: data)
          let postData = postInfo[0]
          print("decodeOK - ", postData)
          completion(postData, nil)
        } catch {
          completion(nil, .invalideData)
        }
      }
    }.resume()
  }
  
  func postRequest(_ request: URLRequest, completion: @escaping(APIError?) -> Void) {
    URLSession.shared.dataTask(with: request) { data, response, error in
      DispatchQueue.main.async {
        guard error == nil else {
          completion(.failed)
          return
        }
  
        guard let data = data else {
          completion(.noData)
          return
        }
  
        guard let response = response as? HTTPURLResponse else {
          completion(.invalidResponse)
          return
        }
  
        guard response.statusCode == 200 else {
          completion(.failed)
          return
        }
      }
    }.resume()
  }
}

//
//  URLSession++Extension.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import Foundation

extension URLSession {
  func request<T: Decodable>(_ request: URLRequest, completion: @escaping(T?, APIError?) -> Void) {
    URLSession.shared.dataTask(with: request) { data, response, error in
      print(data)
      print(response)
      print(error)
      
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
}

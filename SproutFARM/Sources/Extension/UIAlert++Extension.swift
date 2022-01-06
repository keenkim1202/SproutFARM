//
//  UIAlert++Extension.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import UIKit

extension UIAlertController {
  enum ContentType: String {
    case failToLogin = "로그인 실패"
  }
  
  static func show(_ presentedHost: UIViewController,
                   contentType: ContentType,
                   message: String) {
    let alert = UIAlertController(
      title: contentType.rawValue,
      message: message,
      preferredStyle: .alert)
    let okAction = UIAlertAction(
      title: "확인", style: .default, handler: nil)
    alert.addAction(okAction)
    presentedHost.present(alert, animated: true, completion: nil)
  }
}

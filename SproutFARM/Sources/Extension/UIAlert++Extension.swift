//
//  UIAlert++Extension.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import UIKit

extension UIAlertController {
  enum ContentType: String {
    case success = "성공"
    case failToLogin = "로그인 실패"
    case failToSignUp = "회원가입 실패"
    case failToFetch = "데이터 로드 실패"
    case failToWrite = "작성 실패"
    case failToUpdate = "수정 실패"
    case etc = "⚠️"
  }
  
  static func showAlert(_ presentedHost: UIViewController,
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
  
  static func showAlert(_ presentedHost: UIViewController,
                   contentType: ContentType,
                   message: String,
                   completion: (() -> Void)?) {
    let alert = UIAlertController(
      title: contentType.rawValue,
      message: message,
      preferredStyle: .alert)
    let okAction = UIAlertAction(
      title: "확인", style: .default, handler: nil)
    alert.addAction(okAction)
    presentedHost.present(alert, animated: true, completion: nil)
  }
  
  static func sucessAlert(_ presentedHost: UIViewController,
                          contentType: ContentType,
                          message: String) {
    let alert = UIAlertController(
      title: contentType.rawValue,
      message: message,
      preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "확인", style: .default) { _ in
      presentedHost.navigationController?.popViewController(animated: true)
    }
    alert.addAction(okAction)
    presentedHost.present(alert, animated: true, completion: nil)
  }
  
  static func deleteAlert(_ presentedHost: UIViewController,
                          contentType: ContentType,
                          message: String,
                          completion: @escaping () -> Void
  ) {
    let alert = UIAlertController(
      title: contentType.rawValue,
      message: message,
      preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: "취소", style: .default)
    let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
      completion()
    }
    
    alert.addAction(cancelAction)
    alert.addAction(deleteAction)
    presentedHost.present(alert, animated: true, completion: nil)
  }
}

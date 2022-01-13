//
//  BaseViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    adjustNavigationBarFont()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  // MARK: - Configure
  func configure() {
    view.backgroundColor = .systemBackground
  }
  
  func showAlertMenu(message: String, vc: UIViewController, completion: @escaping () -> Void) {
    let alertMenu = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
    
    let updateAction = UIAlertAction(title: "수정", style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
      // TODO: Comment 정보 넘겨주기
      self.navigationController?.pushViewController(vc, animated: true)
    })
    let deleteAction = UIAlertAction(title: "삭제", style: .destructive, handler: {
      (alert: UIAlertAction!) -> Void in
      // TODO: "정말 삭제하시겠습니까?" alert 띄우기
      UIAlertController.deleteAlert(self, contentType: .etc, message: "정말 삭제하시겠습니까?") {
        completion()
      }
    })
    let cancelAction = UIAlertAction(title: "취소", style: .cancel)
    
    alertMenu.addAction(updateAction)
    alertMenu.addAction(deleteAction)
    alertMenu.addAction(cancelAction)
    
    self.present(alertMenu, animated: true, completion: nil)
  }
  
  func adjustNavigationBarFont() {
    self.navigationController?.navigationBar.titleTextAttributes = [
      NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15)!
    ]
  }
}

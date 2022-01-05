//
//  BaseViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit

class BaseViewController: UIViewController {
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  // MARK: - Configure
  func configure() {
    view.backgroundColor = .systemBackground
  }
  
  func showAlertMenu(message: String) {
    let alertMenu = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
    
    let updateAction = UIAlertAction(title: "수정", style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
    })
    let deleteAction = UIAlertAction(title: "삭제", style: .destructive, handler: {
      (alert: UIAlertAction!) -> Void in
    })
    let cancelAction = UIAlertAction(title: "취소", style: .cancel)
    
    alertMenu.addAction(updateAction)
    alertMenu.addAction(deleteAction)
    alertMenu.addAction(cancelAction)
    
    self.present(alertMenu, animated: true, completion: nil)
  }
}

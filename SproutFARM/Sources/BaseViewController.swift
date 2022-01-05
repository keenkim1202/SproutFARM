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
    adjustNavigationBarFont()
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
  
  func adjustNavigationBarFont() {
    self.navigationController?.navigationBar.titleTextAttributes = [
      NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15)!
    ]
    // 
    // let BarButtonTextAttributes: [NSAttributedString.Key: Any] = [
    //     .font: UIFont(name: "HelveticaNeue-Bold", size: 10)!
    // ]
    // 
    // if let leftBarButtons = self.navigationItem.leftBarButtonItems {
    //   for button in leftBarButtons {
    //     button.setTitleTextAttributes(BarButtonTextAttributes, for: .normal)
    //     button.setTitleTextAttributes(BarButtonTextAttributes, for: .highlighted)
    //   }
    // }
    // 
    // if let rightBarButtons = self.navigationItem.rightBarButtonItems {
    //   for button in rightBarButtons {
    //     button.setTitleTextAttributes(BarButtonTextAttributes, for: .normal)
    //     button.setTitleTextAttributes(BarButtonTextAttributes, for: .highlighted)
    //   }
    // }
  }
}

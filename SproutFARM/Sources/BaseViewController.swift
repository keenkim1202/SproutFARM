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
}
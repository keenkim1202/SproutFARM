//
//  RegisterViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit
import SnapKit

class RegisterViewController: BaseViewController {
  
  let registerView = RegisterView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    self.title = "새싹농장 가입하기"
    setConstraints()
    registerView.registerButton.addTarget(self, action: #selector(onRegister), for: .touchUpInside)
  }
  
  func setConstraints() {
    view.addSubview(registerView)
    registerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  @objc func onRegister() {
    print("register")

  }
}

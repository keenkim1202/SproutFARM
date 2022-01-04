//
//  RegisterViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit
import SnapKit

// TODO: textField 채움 여부에 따라 registerButton disable/enable
class RegisterViewController: BaseViewController {
  
  // MARK: - UI
  let registerView = RegisterView()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
   
    self.title = "새싹농장 가입하기"
    setConstraints()
    registerView.registerButton.addTarget(self, action: #selector(onRegister), for: .touchUpInside)
    
  }
  
  // MARK: - Configure
  func setConstraints() {
    view.addSubview(registerView)
    registerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  // MARK: - Actions
  @objc func onRegister() {
    print("register")
  }
  
}

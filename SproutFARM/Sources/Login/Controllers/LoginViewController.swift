//
//  ViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {

  // MARK: - UI
  let loginView = LoginView()
  
  // MARK: - View Life-Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "로그인"
    setConstraints()
    loginView.loginButton.addTarget(self, action: #selector(onLogin), for: .touchUpInside)
  }
  
  // MARK: - SetConstraints
  func setConstraints() {
    view.addSubview(loginView)
    loginView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  // MARK: - Action
  @objc func onLogin() {
    print("login")
    // login success
    
    
    let email = loginView.emailTextField.text!
    let password = loginView.passwordTextField.text!
    APIService.login(email: email, password: password) { user, error in
      guard error == nil else {
        // login fail
        print("login failed")
        UIAlertController.show(self, contentType: .failToLogin, message: "이메일과 비밀번호를 확인해주세요.")
        return
      }

      // login success
      print("login success")
      self.navigationController?.pushViewController(PostListViewController(), animated: true)
    }
    
  }
}

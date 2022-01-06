//
//  RegisterViewController.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/03.
//

import UIKit

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
    
    let username = registerView.nicknameTextField.text!
    let email = registerView.emailTextField.text!
    let password = registerView.passwordTextField.text!
  
    APIService.signUp(username: username, email: email, password: password) { user, error in
      guard error == nil else {
        print("register failed")
        UIAlertController.showAlert(self, contentType: .failToSignUp, message: "올바르게 입력하였는지 확인 후\n다시 시도해주세요.")
        return
      }
      
      print("register success")
      UIAlertController.sucessAlert(self, contentType: .successToSignUp, message: "회원가입에 성공하였습니다.\n로그인을 시도해주세요!")
    }
  }
  
}

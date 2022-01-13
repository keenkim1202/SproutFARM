//
//  LoginView.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/04.
//

import UIKit
import SnapKit

class LoginView: UIView {
  
  // MARK: - UI
  let emailTextField: UITextField = {
    let t = UITextField()
    t.placeholder = "이메일 주소"
    t.borderStyle = .roundedRect
    t.font = .systemFont(ofSize: 14, weight: .bold)
    t.layer.cornerRadius = 5
    t.addLeftPadding()
    return t
  }()
  
  let passwordTextField: UITextField = {
    let t = UITextField()
    t.placeholder = "비밀번호"
    t.borderStyle = .roundedRect
    t.isSecureTextEntry = true
    t.font = .systemFont(ofSize: 14, weight: .bold)
    t.layer.cornerRadius = 5
    t.addLeftPadding()
    return t
  }()
  
  var loginButton: UIButton = {
    let b = UIButton()
    b.setTitle("로그인", for: .normal)
    b.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
    b.backgroundColor = .systemGray4
    b.layer.cornerRadius = 5
    b.isEnabled = false
    return b
  }()
  
  // MARK: - Init
  override init(frame: CGRect) {
      super.init(frame: frame)
    createViews()
    setConstraints()
    setAddTarget()
  }
  
  required init?(coder: NSCoder) {
      super.init(coder: coder)
    createViews()
    setConstraints()
    setAddTarget()
  }
  
  // MARK: - Configure
  private func setAddTarget() {
    [emailTextField, passwordTextField].forEach {
      $0.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
    }
  }
  
  private func createViews() {
    addSubview(emailTextField)
    addSubview(passwordTextField)
    addSubview(loginButton)
  }
  
  private func setConstraints() {
    emailTextField.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(safeAreaLayoutGuide).offset(20)
      $0.height.equalTo(45)
    }
    
    passwordTextField.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(emailTextField.snp.bottom).offset(10)
      $0.height.equalTo(45)
    }
    
    loginButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
      $0.height.equalTo(45)
    }
  }
  
  @objc func textFieldsIsNotEmpty(sender: UITextField) {
    sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
  
    guard
      let email = emailTextField.text, !email.isEmpty,
      let password = passwordTextField.text, !password.isEmpty
    else {
      self.loginButton.backgroundColor = .systemGray4
      self.loginButton.isEnabled = false
      return
    }
  
    self.loginButton.backgroundColor = .mainGreenColor
    self.loginButton.isEnabled = true
  }
}

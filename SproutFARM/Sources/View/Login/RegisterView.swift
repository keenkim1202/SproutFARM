//
//  RegisterView.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/04.
//

import UIKit
import SnapKit

class RegisterView: UIView {
  
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
  
  let nicknameTextField: UITextField = {
    let t = UITextField()
    t.placeholder = "닉네임"
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
    t.font = .systemFont(ofSize: 14, weight: .bold)
    t.layer.cornerRadius = 5
    t.addLeftPadding()
    return t
  }()
  
  let confirmTextField: UITextField = {
    let t = UITextField()
    t.placeholder = "비밀번호 확인"
    t.borderStyle = .roundedRect
    t.font = .systemFont(ofSize: 14, weight: .bold)
    t.layer.cornerRadius = 5
    t.addLeftPadding()
    return t
  }()
  
  var registerButton: UIButton = {
    let b = UIButton()
    b.setTitle("가입하기", for: .normal)
    b.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
    b.backgroundColor = .systemGray4
    b.layer.cornerRadius = 5
    return b
  }()
  
  // MARK: - Init
  override init(frame: CGRect) {
      super.init(frame: frame)
    createViews()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
      super.init(coder: coder)
    createViews()
    setConstraints()
  }
  
  // MARK: - Configure
  private func createViews() {
    addSubview(emailTextField)
    addSubview(nicknameTextField)
    addSubview(passwordTextField)
    addSubview(confirmTextField)
    addSubview(registerButton)
  }
  
  private func setConstraints() {
    emailTextField.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(safeAreaLayoutGuide).offset(20)
      $0.height.equalTo(45)
    }
    
    nicknameTextField.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(emailTextField.snp.bottom).offset(10)
      $0.height.equalTo(45)
    }
    
    passwordTextField.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(nicknameTextField.snp.bottom).offset(10)
      $0.height.equalTo(45)
    }
    
    confirmTextField.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
      $0.height.equalTo(45)
    }
    
    registerButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(confirmTextField.snp.bottom).offset(10)
      $0.height.equalTo(45)
    }
  }
}

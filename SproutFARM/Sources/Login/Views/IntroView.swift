//
//  IntroView.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/04.
//

import UIKit
import SnapKit

class IntroView: UIView {
  
  // MARK: - UI
  var contentStackView: UIStackView = {
    let s = UIStackView()
    s.axis = .vertical
    s.alignment = .center
    s.spacing = 10
    return s
  }()
  
  var loginStackView: UIStackView = {
    let s = UIStackView()
    s.axis = .horizontal
    s.alignment = .center
    s.spacing = 5
    return s
  }()
  
  let logoImageView: UIImageView = {
    let i = UIImageView()
    i.image = .sacLogo
    i.contentMode = .scaleAspectFit
    i.backgroundColor = .white
    return i
  }()
  
  let titleLabel: UILabel = {
    let l = UILabel()
    l.text = "당신 근처의 새싹 농장"
    l.font = .systemFont(ofSize: 17, weight: .bold)
    l.textAlignment = .center
    return l
  }()
  
  let subtitleLabel: UILabel = {
    let l = UILabel()
    l.text = "iOS 지식부터 바람의 나라까지\n지금 SeSAC에서 함께해보세요!"
    l.font = .systemFont(ofSize: 13, weight: .regular)
    l.textAlignment = .center
    l.numberOfLines = 0
    return l
  }()
  
  let loginLabel: UILabel = {
    let l = UILabel()
    l.text = "이미 계정이 있나요?"
    l.font = .systemFont(ofSize: 13, weight: .regular)
    l.textColor = .lightGray
    l.textAlignment = .center
    return l
  }()
  
  let startButton: UIButton = {
    let b = UIButton()
    b.setTitle("시작하기", for: .normal)
    b.backgroundColor = .mainGreenColor
    b.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
    b.layer.cornerRadius = 8
    return b
  }()
  
  let loginButton: UIButton = {
    let b = UIButton()
    b.setTitle("로그인", for: .normal)
    b.setTitleColor(.mainGreenColor, for: .normal)
    b.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
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
    addSubview(contentStackView)
    addSubview(loginStackView)
    addSubview(startButton)
    
    loginStackView.addArrangedSubview(loginLabel)
    loginStackView.addArrangedSubview(loginButton)
    
    contentStackView.addArrangedSubview(logoImageView)
    contentStackView.addArrangedSubview(titleLabel)
    contentStackView.addArrangedSubview(subtitleLabel)
  }
  
  private func setConstraints() {
    contentStackView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.centerX.centerY.equalToSuperview()
    }
    
    logoImageView.snp.makeConstraints {
      $0.height.equalTo(150)
    }
    
    startButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalTo(loginStackView.snp.top).offset(-10)
      $0.height.equalTo(40)
    }
    
    loginStackView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(safeAreaLayoutGuide).offset(-10)
    }
  }
}

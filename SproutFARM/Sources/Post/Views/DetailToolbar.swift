//
//  DetailToolbar.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/04.
//

import UIKit
import SnapKit

class DetailToolbar: UIView {
  
  // MARK: - Metric
  struct Metric {
    static let leadingTrailingInset: CGFloat = 20
    static let textFieldHeight: CGFloat = 35
    static let buttonWidth: CGFloat = 55
    static let toolbarHeight: CGFloat = 50
  }
  
  // MARK: - UI
  let toolbar: UIToolbar = {
    let t = UIToolbar()
    t.barTintColor = .systemBackground
    return t
  }()
  
  let commentTextField: UITextField = {
    let t = UITextField()
    t.placeholder = "댓글을 입력해주세요"
    t.borderStyle = .none
    t.font = .systemFont(ofSize: 14, weight: .bold)
    t.layer.cornerRadius = 15
    t.backgroundColor = .systemGray6
    t.addLeftPadding()
    return t
  }()
  
  let doneButton: UIButton = {
    let b = UIButton()
    b.setTitle("작성", for: .normal)
    b.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
    b.tintColor = .white
    b.backgroundColor = .mainGreenColor
    b.layer.cornerRadius = 15
    b.addTarget(self, action: #selector(onDone), for: .touchUpInside)
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
    
  }
  
  private func setConstraints() {
    addSubview(toolbar)
    toolbar.addSubview(commentTextField)
    toolbar.addSubview(doneButton)
    
    toolbar.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(safeAreaLayoutGuide)
      $0.height.equalTo(Metric.toolbarHeight)
    }
    
    commentTextField.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailingInset)
      $0.trailing.equalTo(doneButton.snp.leading).offset(-5)
      $0.centerY.equalTo(toolbar.snp.centerY)
      $0.height.equalTo(Metric.textFieldHeight)
    }
    
    doneButton.snp.makeConstraints {
      $0.leading.equalTo(commentTextField.snp.trailing).offset(5)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailingInset)
      $0.centerY.equalTo(toolbar.snp.centerY)
      $0.height.equalTo(Metric.textFieldHeight)
      $0.width.equalTo(Metric.buttonWidth)
    }
  }
  
  @objc func onDone(_ sender: UIButton) {
    commentTextField.resignFirstResponder()
  }
}

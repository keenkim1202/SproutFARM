//
//  EditCommentView.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/06.
//

import UIKit

class EditCommentView: UIView {
  // MARK: - Metric
  struct Metric {
    static let leadingTrailingInset: CGFloat = 15
    static let topBottomInset: CGFloat = 15
    static let textViewHeight: CGFloat = 100
  }
  
  // MARK: - UI
  let textView: UITextView = {
    let t = UITextView()
    t.layer.borderColor = UIColor.lightGray.cgColor
    t.layer.borderWidth = 1
    return t
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
    addSubview(textView)
  }
  
  private func setConstraints() {
    textView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailingInset)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailingInset)
      $0.top.equalToSuperview().offset(Metric.topBottomInset)
      $0.height.equalTo(Metric.textViewHeight)
    }
  }
}


//
//  CommentListCell.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/05.
//

import UIKit
import SnapKit

class CommentListCell: UITableViewCell {
  
  // MARK: - Metric
  struct Metric {
    static let leadingTrailingInset: CGFloat = 15
    static let topBottomInset: CGFloat = 10
  }
  
  // MARK: - Property
  static let identifier = "CommentListCell"
  
  // MARK: - UI
  let nicknameLabel: UILabel = {
    let l = UILabel()
    l.text = "nickname"
    l.font = .systemFont(ofSize: 13, weight: .bold)
    l.textColor = .lightGray
    return l
  }()
  
  let contentLabel: UILabel = {
    let l = UILabel()
    l.text = "댓글내용 입니다. 댓글내용 입니다. 댓글내용 입니다. 댓글내용 입니다. 댓글내용 입니다. 댓글내용 입니다."
    l.font = .systemFont(ofSize: 12, weight: .regular)
    l.textColor = .systemGray
    return l
  }()
  
  let editButton: UIButton = {
    let b = UIButton()
    return b
  }()
  
  let stackView: UIStackView = {
    let s = UIStackView()
    s.axis = .horizontal
    s.spacing = 5
    return s
  }()
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    addSubview(editButton)
    addSubview(stackView)
    stackView.addSubview(nicknameLabel)
    stackView.addSubview(contentLabel)
  }
  
  private func setConstraints() {
    stackView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailingInset)
      $0.top.equalToSuperview().offset(Metric.topBottomInset)
      $0.bottom.equalToSuperview().offset(-Metric.topBottomInset)
    }
    
    editButton.snp.makeConstraints {
      $0.leading.equalTo(stackView.snp.trailing).offset(Metric.leadingTrailingInset)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailingInset)
      $0.top.equalToSuperview().offset(Metric.topBottomInset)
      $0.bottom.equalToSuperview().offset(-Metric.topBottomInset)
    }
  }
}

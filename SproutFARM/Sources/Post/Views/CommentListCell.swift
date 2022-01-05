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
    return l
  }()
  
  let contentLabel: UILabel = {
    let l = UILabel()
    l.text = "댓글내용 입니다. 댓글내용 입니다. 댓글내용 입니다. 댓글내용 입니다. 댓글내용 입니다. 댓글내용 입니다."
    l.numberOfLines = 0
    l.font = .systemFont(ofSize: 12, weight: .regular)
    return l
  }()
  
  let editButton: UIButton = {
    let b = UIButton()
    b.setImage(UIImage(systemName: "ellipsis"), for: .normal)
    b.tintColor = .darkGray
    b.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
    return b
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
    addSubview(nicknameLabel)
    addSubview(contentLabel)
    addSubview(editButton)
  }
  
  private func setConstraints() {
    
    nicknameLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailingInset)
      $0.trailing.equalTo(editButton.snp.leading).offset(-Metric.leadingTrailingInset)
      $0.top.equalToSuperview().offset(Metric.topBottomInset)
      $0.bottom.equalTo(contentLabel.snp.top).offset(-Metric.topBottomInset)
    }
    
    contentLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailingInset)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailingInset)
      $0.top.equalTo(nicknameLabel.snp.bottom).offset(Metric.topBottomInset)
      $0.bottom.equalToSuperview().offset(-Metric.topBottomInset)
    }
    
    editButton.snp.makeConstraints {
      $0.leading.equalTo(nicknameLabel.snp.trailing).offset(Metric.leadingTrailingInset)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailingInset)
      $0.top.equalToSuperview().offset(Metric.topBottomInset)
      $0.width.equalTo(nicknameLabel.snp.height)
      $0.height.equalTo(editButton.snp.width)
      
    }
  }
}

//
//  PostListCell.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/04.
//

import UIKit
import SnapKit

class PostListCell: UITableViewCell {
  
  // MARK: - Metric
  struct Metric {
    static let leadingTrailingInset: CGFloat = 15
    static let topBottomInset: CGFloat = 15
    static let labelPadding: CGFloat = 10
  }
  
  // MARK: - Properties
  static let identifier = "PostCell"
  
  // MARK: - UI
  let nicknameView: UIView = {
    let v = UIView()
    v.backgroundColor = .systemGray6
    v.layer.cornerRadius = 5
    return v
  }()
  
  let nicknameLabel: UILabel = {
    let l = UILabel()
    l.text = "이름 없음"
    l.font = .systemFont(ofSize: 12, weight: .medium)
    l.textColor = .systemGray
    return l
  }()
  
  let contentLabel: UILabel = {
    let l = UILabel()
    l.text = "내용 없음"
    l.font = .systemFont(ofSize: 13, weight: .medium)
    l.numberOfLines = 3
    return l
  }()
  
  let dateLabel: UILabel = {
    let l = UILabel()
    l.font = .systemFont(ofSize: 12, weight: .regular)
    l.textColor = .systemGray
    return l
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
    
    addSubview(nicknameView)
    addSubview(contentLabel)
    addSubview(dateLabel)
    nicknameView.addSubview(nicknameLabel)
  }
  
  private func setConstraints() {
    nicknameView.snp.makeConstraints {
      $0.leading.top.equalToSuperview().offset(Metric.topBottomInset)
      $0.width.equalTo(nicknameLabel.snp.width).offset(Metric.labelPadding)
      $0.height.equalTo(nicknameLabel.snp.height).offset(Metric.labelPadding)
    }
    
    nicknameLabel.snp.makeConstraints {
      $0.centerX.centerY.equalTo(nicknameView)
    }
    
    contentLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailingInset)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailingInset)
      $0.top.equalTo(nicknameView.snp.bottom).offset(Metric.topBottomInset)
    }
    
    dateLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailingInset)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailingInset)
      $0.top.equalTo(contentLabel.snp.bottom).offset(Metric.topBottomInset)
      $0.bottom.equalToSuperview().offset(-Metric.topBottomInset)
    }
    
  }
}

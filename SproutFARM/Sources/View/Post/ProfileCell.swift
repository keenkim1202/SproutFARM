//
//  ProfileCell.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/05.
//

import UIKit
import SnapKit

class ProfileCell: UITableViewCell {
  
  // MARK: - Metric
  struct Metric {
    static let leadingTrailingInset: CGFloat = 15
    static let topBottomInset: CGFloat = 15
    static let labelInset: CGFloat = 3
  }
  
  // MARK: - Property
  static let identifier = "ProfileCell"
  
  // MARK: - UI
  let profileImageView: UIImageView = {
    let i = UIImageView()
    i.image = UIImage(systemName: "person.circle")
    i.tintColor = .systemGray
    return i
  }()
  
  let nicknameLabel: UILabel = {
    let l = UILabel()
    l.text = "myNickname"
    l.font = .systemFont(ofSize: 13, weight: .bold)
    return l
  }()
  
  let dateLabel: UILabel = {
    let l = UILabel()
    l.text = "01/01"
    l.font = .systemFont(ofSize: 11, weight: .bold)
    l.textColor = .lightGray
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
    addSubview(profileImageView)
    addSubview(nicknameLabel)
    addSubview(dateLabel)
  }
  
  private func setConstraints() {
    profileImageView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailingInset)
      $0.top.equalToSuperview().offset(Metric.topBottomInset)
      $0.bottom.equalToSuperview().offset(-Metric.topBottomInset)
      $0.width.equalTo(profileImageView.snp.height)
    }
    
    nicknameLabel.snp.makeConstraints {
      $0.leading.equalTo(profileImageView.snp.trailing).offset(Metric.leadingTrailingInset)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailingInset)
      $0.top.equalToSuperview().offset(Metric.topBottomInset)
      $0.bottom.equalTo(dateLabel.snp.top).offset(-Metric.labelInset)
    }
    
    dateLabel.snp.makeConstraints {
      $0.leading.equalTo(profileImageView.snp.trailing).offset(Metric.leadingTrailingInset)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailingInset)
      $0.top.equalTo(nicknameLabel.snp.bottom).offset(Metric.labelInset)
      $0.bottom.equalToSuperview().offset(-Metric.topBottomInset)
    }
  }
}


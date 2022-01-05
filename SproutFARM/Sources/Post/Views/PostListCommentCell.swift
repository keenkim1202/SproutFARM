//
//  PostListCommentCell.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/04.
//

import UIKit
import SnapKit

class PostListCommentCell: UITableViewCell {
  
  // MARK: - Metric
  struct Metric {
    static let leadingTrailingInset: CGFloat = 15
    static let topBottomInset: CGFloat = 10
  }
  
  // MARK: - Property
  static let identifier = "PostListCommentCell"
  
  // MARK: - UI
  let commentImageView: UIImageView = {
    let i = UIImageView()
    i.image = UIImage(systemName: "bubble.right")
    i.contentMode = .scaleAspectFit
    i.tintColor = .systemGray
    return i
  }()
  
  let label: UILabel = {
    let l = UILabel()
    l.text = "댓글쓰기"
    l.font = .systemFont(ofSize: 13, weight: .medium)
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
    addSubview(commentImageView)
    addSubview(label)
  }
  
  private func setConstraints() {
    commentImageView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailingInset)
      $0.top.equalToSuperview().offset(Metric.topBottomInset)
      $0.bottom.equalToSuperview().offset(-Metric.topBottomInset)
      $0.width.equalTo(commentImageView.snp.height)
    }
    
    label.snp.makeConstraints {
      $0.leading.equalTo(commentImageView.snp.trailing).offset(Metric.leadingTrailingInset)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailingInset)
      $0.top.equalToSuperview().offset(Metric.topBottomInset)
      $0.bottom.equalToSuperview().offset(-Metric.topBottomInset)
    }
  }
}

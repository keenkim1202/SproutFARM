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
  let postView = PostView()
  let commentView = CommentView()
  
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
    
    addSubview(postView)
    addSubview(commentView)
  }
  
  private func setConstraints() {
    postView.snp.makeConstraints {
      $0.leading.top.trailing.equalToSuperview()
      $0.bottom.equalTo(commentView.snp.top)
    }
    
    commentView.snp.makeConstraints {
      $0.leading.bottom.trailing.equalToSuperview()
      $0.top.equalTo(postView.snp.bottom)
    }
  }
}

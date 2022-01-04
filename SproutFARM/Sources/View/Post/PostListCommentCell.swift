//
//  PostListCommentCell.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/04.
//

import UIKit
import SnapKit

class PostListCommentCell: UIView {
  // MARK: - UI
  let imageView: UIImageView = {
    let i = UIImageView()
    i.image = UIImage(systemName: "bubble.right")
    i.contentMode = .scaleAspectFit
    i.tintColor = .lightGray
    return i
  }()
  
  let label: UILabel = {
    let l = UILabel()
    l.text = "댓글쓰기"
    l.textColor = .lightGray
    return l
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
    
  }
}

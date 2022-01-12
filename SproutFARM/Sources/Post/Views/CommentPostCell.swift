//
//  CommentPostCell.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/12.
//

import UIKit

class CommentPostCell: UITableViewCell {

  // MARK: - Metric
  struct Metric {
    static let cellInset: CGFloat = 15
  }
  
  // MARK: - Property
  static let identifier = "CommentPostCell"
  
  // MARK: - UI
  let postTextLabel: UILabel = {
    let l = UILabel()
    l.text = "post text"
    l.font = .systemFont(ofSize: 13, weight: .medium)
    l.numberOfLines = 0
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
    addSubview(postTextLabel)
  }
  
  private func setConstraints() {
    postTextLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.cellInset)
      $0.trailing.equalToSuperview().offset(-Metric.cellInset)
      $0.top.equalToSuperview().offset(Metric.cellInset)
      $0.bottom.equalToSuperview().offset(-Metric.cellInset)
    }
  }
}

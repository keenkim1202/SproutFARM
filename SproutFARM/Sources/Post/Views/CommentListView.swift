//
//  CommentListView.swift
//  SproutFARM
//
//  Created by KEEN on 2022/01/16.
//

import UIKit

class CommentListView: UIView {
  
  // MARK: - Metric
  struct Metric {
    static let toolbarHeight: CGFloat = 50
  }
  
  // MARK: - UI
  let tableView: UITableView = {
    let t = UITableView()
    t.cellLayoutMarginsFollowReadableWidth = false
    t.separatorInset.left = 0
    return t
  }()
  
  let toolbar = DetailToolbar()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    createViews()
    setConstraints()
    setTableView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    createViews()
    setConstraints()
    setTableView()
  }
  
  // MARK: - Configure
  func setTableView() {
    tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
    tableView.register(CommentPostCell.self, forCellReuseIdentifier: CommentPostCell.identifier)
    tableView.register(PostListCommentCell.self, forCellReuseIdentifier: PostListCommentCell.identifier)
    tableView.register(CommentListCell.self, forCellReuseIdentifier: CommentListCell.identifier)
  }
  
  private func createViews() {
    addSubview(tableView)
    addSubview(toolbar)
  }
  
  func setConstraints() {
    addSubview(tableView)
    addSubview(toolbar)
    
    tableView.snp.makeConstraints {
      $0.leading.trailing.top.equalTo(self.safeAreaLayoutGuide)
      $0.bottom.equalTo(toolbar.snp.top)
    }
    
    toolbar.snp.makeConstraints {
      $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
      $0.bottom.equalTo(self.safeAreaLayoutGuide)
      $0.height.equalTo(Metric.toolbarHeight)
    }
  }
}

// MARK: - Extension
extension DetailPostViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 3
    } else {
      return commentList.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      if indexPath.row == 0 { // profile
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as? ProfileCell else { return UITableViewCell() }
        
        if let post = post {
          if post.user.username.isEmpty {
            cell.nicknameLabel.text = "(이름 없음)"
          } else {
            cell.nicknameLabel.text = post.user.username
          }

          let date = DateFormatter().toString(date: post.updatedAt)
          cell.dateLabel.text = date
        }
        
        cell.selectionStyle = .none
        return cell
      } else if indexPath.row == 1 { // post content
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentPostCell.identifier, for: indexPath) as? CommentPostCell else { return UITableViewCell() }
        
        if let post = post {
          cell.postTextLabel.text = post.text
        }
        
        cell.selectionStyle = .none
        return cell
      } else if indexPath.row == 2 { // comment
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostListCommentCell.identifier, for: indexPath) as? PostListCommentCell else { return UITableViewCell() }
        
        if !commentList.isEmpty {
          cell.label.text = "댓글 \(commentList.count)"
        }
        
        cell.selectionStyle = .none
        return cell
      } else {
        return UITableViewCell()
      }
    } else { // comment content
      guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentListCell.identifier, for: indexPath) as? CommentListCell else { return UITableViewCell() }
      let comment = commentList[indexPath.row]
      
      if comment.user.username.isEmpty {
        cell.nicknameLabel.text = "(이름 없음)"
      } else {
        cell.nicknameLabel.text = comment.user.username
      }
      
      cell.contentLabel.text = comment.comment
      
      let date = DateFormatter().toString(date: comment.updatedAt)
      cell.dateLabel.text = date
      cell.selectionStyle = .none
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    commentListView.toolbar.commentTextField.endEditing(true)
  }
}
